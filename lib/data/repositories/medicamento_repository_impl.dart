import 'dart:convert';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/data/remote/supabase/audit_remote.dart';
import 'package:medicamentos_app/data/remote/supabase/medicamentos_remote.dart';
import 'package:medicamentos_app/data/sync/sync_manager.dart';
import 'package:medicamentos_app/domain/entities/medicamento.dart';
import 'package:medicamentos_app/domain/repositories/medicamento_repository.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class MedicamentoRepositoryImpl implements MedicamentoRepository {
  final AppDatabase _db;
  final MedicamentosRemote _remote;
  final AuditRemote _auditRemote;
  final SyncManager _syncManager;
  static const _uuid = Uuid();

  MedicamentoRepositoryImpl({
    required AppDatabase db,
    required MedicamentosRemote remote,
    required AuditRemote auditRemote,
    required SyncManager syncManager,
  })  : _db = db,
        _remote = remote,
        _auditRemote = auditRemote,
        _syncManager = syncManager;

  // Convierte de tabla Drift a entidad
  Medicamento _fromTable(MedicamentosTableData d) {
    return Medicamento(
      id: d.id,
      codigoBarras: d.codigoBarras,
      nombre: d.nombre,
      descripcion: d.descripcion,
      fotoUrl: d.fotoUrl,
      dosisAdulto: d.dosisAdulto,
      dosisMayor: d.dosisMayor,
      dosisNino: d.dosisNino,
      alergias: AppDatabase.jsonToList(d.alergias),
      contraindicaciones: AppDatabase.jsonToList(d.contraindicaciones),
      enfermedadesIncompatibles:
          AppDatabase.jsonToList(d.enfermedadesIncompatibles),
      actualizadoEn: d.actualizadoEn,
      eliminado: d.eliminado,
    );
  }

  // Convierte entidad a companion Drift
  MedicamentosTableCompanion _toCompanion(Medicamento m) {
    return MedicamentosTableCompanion(
      id: Value(m.id),
      codigoBarras: Value(m.codigoBarras),
      nombre: Value(m.nombre),
      descripcion: Value(m.descripcion),
      fotoUrl: Value(m.fotoUrl),
      dosisAdulto: Value(m.dosisAdulto),
      dosisMayor: Value(m.dosisMayor),
      dosisNino: Value(m.dosisNino),
      alergias: Value(AppDatabase.listToJson(m.alergias)),
      contraindicaciones: Value(AppDatabase.listToJson(m.contraindicaciones)),
      enfermedadesIncompatibles:
          Value(AppDatabase.listToJson(m.enfermedadesIncompatibles)),
      actualizadoEn: Value(m.actualizadoEn),
      eliminado: Value(m.eliminado),
      sincronizado: const Value(false),
    );
  }

  @override
  Future<List<Medicamento>> getAll() async {
    final rows = await _db.medicamentosDao.getAll();
    return rows.map(_fromTable).toList();
  }

  @override
  Future<Medicamento?> buscarPorCodigo(String codigo) async {
    final row = await _db.medicamentosDao.buscarPorCodigo(codigo);
    return row != null ? _fromTable(row) : null;
  }

  @override
  Future<List<Medicamento>> buscarPorNombre(String query) async {
    final rows = await _db.medicamentosDao.buscarPorNombre(query);
    return rows.map(_fromTable).toList();
  }

  @override
  Future<List<Medicamento>> getFavoritos() async {
    final rows = await _db.medicamentosDao.getFavoritos();
    return rows.map(_fromTable).toList();
  }

  @override
  Future<void> guardar(
    Medicamento medicamento, {
    required String usuarioNombre,
    required String dispositivoId,
  }) async {
    // Verificar si existe para saber si es CREAR o EDITAR
    final existe = await _db.medicamentosDao.buscarPorCodigo(
      medicamento.codigoBarras,
    );
    final accion = existe != null ? 'EDITAR' : 'CREAR';

    // Guardar local
    await _db.medicamentosDao.upsert(_toCompanion(medicamento));

    // Audit
    final auditData = {
      'id': _uuid.v4(),
      'usuario_nombre': usuarioNombre,
      'dispositivo_id': dispositivoId,
      'accion': accion,
      'tabla': 'medicamentos',
      'registro_id': medicamento.id,
      'datos_antes': existe != null
          ? {'nombre': existe.nombre, 'codigo_barras': existe.codigoBarras}
          : null,
      'datos_despues': {
        'nombre': medicamento.nombre,
        'codigo_barras': medicamento.codigoBarras,
      },
      'fecha': DateTime.now().toIso8601String(),
    };

    // Intentar sync inmediato
    try {
      await _remote.upsert(medicamento.toMap());
      await _db.medicamentosDao.marcarSincronizado(medicamento.id);
      await _auditRemote.registrar(auditData);
    } catch (_) {
      // Sin internet — encolar
      await _syncManager.encolar(
        tipo: 'upsert',
        data: medicamento.toMap(),
        audit: auditData,
      );
    }
  }

  @override
  Future<void> eliminar(
    String id, {
    required String usuarioNombre,
    required String dispositivoId,
  }) async {
    final med = (await _db.medicamentosDao.getAll())
        .firstWhere((m) => m.id == id);

    // Soft delete local
    await _db.medicamentosDao.eliminar(id);

    final auditData = {
      'id': _uuid.v4(),
      'usuario_nombre': usuarioNombre,
      'dispositivo_id': dispositivoId,
      'accion': 'ELIMINAR',
      'tabla': 'medicamentos',
      'registro_id': id,
      'datos_antes': {'nombre': med.nombre, 'codigo_barras': med.codigoBarras},
      'datos_despues': null,
      'fecha': DateTime.now().toIso8601String(),
    };

    try {
      await _remote.eliminar(id);
      await _auditRemote.registrar(auditData);
    } catch (_) {
      await _syncManager.encolar(
        tipo: 'eliminar',
        data: {'id': id},
        audit: auditData,
      );
    }
  }

  @override
  Future<void> toggleFavorito(String id, bool valor) async {
    await _db.medicamentosDao.toggleFavorito(id, valor);
  }

  @override
  Future<void> sincronizar() async {
    await _syncManager.sincronizarInicial();
    await _syncManager.subirPendientes();
  }
}