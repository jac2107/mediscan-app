import 'dart:convert';
import 'package:medicamentos_app/core/network/connectivity_service.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/data/remote/supabase/medicamentos_remote.dart';
import 'package:medicamentos_app/data/remote/supabase/audit_remote.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class SyncManager {
  final AppDatabase _db;
  final MedicamentosRemote _remote;
  final AuditRemote _auditRemote;
  final ConnectivityService _connectivity;
  static const _uuid = Uuid();

  SyncManager({
    required AppDatabase db,
    required MedicamentosRemote remote,
    required AuditRemote auditRemote,
    required ConnectivityService connectivity,
  })  : _db = db,
        _remote = remote,
        _auditRemote = auditRemote,
        _connectivity = connectivity;

  // Descarga inicial desde Supabase → SQLite
  Future<void> sincronizarInicial() async {
    final conectado = await _connectivity.isConnected;
    if (!conectado) return;

    final remotos = await _remote.getAll();
    for (final m in remotos) {
      await _db.medicamentosDao.upsert(
        MedicamentosTableCompanion(
          id: Value(m['id'] as String),
          codigoBarras: Value(m['codigo_barras'] as String),
          nombre: Value(m['nombre'] as String),
          descripcion: Value(m['descripcion'] as String?),
          fotoUrl: Value(m['foto_url'] as String?),
          dosisAdulto: Value(m['dosis_adulto'] as String?),
          dosisMayor: Value(m['dosis_mayor'] as String?),
          dosisNino: Value(m['dosis_nino'] as String?),
          alergias: Value(m['alergias'] != null
              ? jsonEncode(m['alergias'])
              : '[]'),
          contraindicaciones: Value(m['contraindicaciones'] != null
              ? jsonEncode(m['contraindicaciones'])
              : '[]'),
          enfermedadesIncompatibles: Value(
              m['enfermedades_incompatibles'] != null
                  ? jsonEncode(m['enfermedades_incompatibles'])
                  : '[]'),
          actualizadoEn: Value(DateTime.parse(m['actualizado_en'] as String)),
          sincronizado: const Value(true),
        ),
      );
    }
  }

  // Sube cambios pendientes de la cola
  Future<void> subirPendientes() async {
    final conectado = await _connectivity.isConnected;
    if (!conectado) return;

    final pendientes = await _db.syncQueueDao.getPendientes();

    for (final item in pendientes) {
      try {
        final op = jsonDecode(item.operacion) as Map<String, dynamic>;
        final tipo = op['tipo'] as String;

        if (tipo == 'upsert') {
          await _remote.upsert(op['data'] as Map<String, dynamic>);
        } else if (tipo == 'eliminar') {
          await _remote.eliminar(op['id'] as String);
        }

        if (op['audit'] != null) {
          await _auditRemote.registrar(op['audit'] as Map<String, dynamic>);
        }

        await _db.syncQueueDao.marcarSincronizado(item.id);
      } catch (e) {
        // Si falla, se reintenta en la próxima sync
        continue;
      }
    }
  }

  // Agrega operación a la cola offline
  Future<void> encolar({
    required String tipo,
    required Map<String, dynamic> data,
    Map<String, dynamic>? audit,
  }) async {
    final operacion = jsonEncode({
      'tipo': tipo,
      'data': data,
      if (audit != null) 'audit': audit,
    });

    await _db.syncQueueDao.agregar(
      SyncQueueTableCompanion(
        id: Value(_uuid.v4()),
        operacion: Value(operacion),
        creadoEn: Value(DateTime.now()),
      ),
    );
  }

  // Escuchar cambios remotos en tiempo real
  void escucharRealtime() {
    _remote.escucharCambios(
      onInsert: (payload) async {
        await _db.medicamentosDao.upsert(_mapToCompanion(payload));
      },
      onUpdate: (payload) async {
        await _db.medicamentosDao.upsert(_mapToCompanion(payload));
      },
      onDelete: (payload) async {
        final id = payload['id'] as String?;
        if (id != null) await _db.medicamentosDao.eliminar(id);
      },
    );
  }

  MedicamentosTableCompanion _mapToCompanion(Map<String, dynamic> m) {
    return MedicamentosTableCompanion(
      id: Value(m['id'] as String),
      codigoBarras: Value(m['codigo_barras'] as String),
      nombre: Value(m['nombre'] as String),
      descripcion: Value(m['descripcion'] as String?),
      fotoUrl: Value(m['foto_url'] as String?),
      dosisAdulto: Value(m['dosis_adulto'] as String?),
      dosisMayor: Value(m['dosis_mayor'] as String?),
      dosisNino: Value(m['dosis_nino'] as String?),
      alergias: Value(m['alergias'] != null ? jsonEncode(m['alergias']) : '[]'),
      contraindicaciones: Value(m['contraindicaciones'] != null
          ? jsonEncode(m['contraindicaciones'])
          : '[]'),
      enfermedadesIncompatibles: Value(m['enfermedades_incompatibles'] != null
          ? jsonEncode(m['enfermedades_incompatibles'])
          : '[]'),
      actualizadoEn: Value(DateTime.parse(m['actualizado_en'] as String)),
      sincronizado: const Value(true),
    );
  }
}