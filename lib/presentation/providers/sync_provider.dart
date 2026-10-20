import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../data/local/database/app_database.dart';
import 'medicamentos_provider.dart';
import 'connectivity_provider.dart';
import 'package:drift/drift.dart';

enum EstadoSync { idle, sincronizando, actualizado, error, offline }

class SyncNotifier extends Notifier<EstadoSync> {
  Timer? _timer;

  @override
  EstadoSync build() {
    Future.delayed(const Duration(seconds: 3), _sincronizar);

    ref.listen(isConnectedProvider, (prev, next) {
      next.whenData((online) {
        if (online && prev?.value == false) {
          _sincronizar();
        }
      });
    });

    _timer = Timer.periodic(const Duration(minutes: 15), (_) => _sincronizar());

    // Realtime listener
    final client = Supabase.instance.client;
    final channel =
        client
            .channel('medicamentos_changes')
            .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'medicamentos',
              callback: (payload) => _sincronizar(),
            )
            .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'catalog_changes',
              callback: (payload) => _sincronizar(),
            )
            .subscribe();

    ref.onDispose(() {
      _timer?.cancel();
      client.removeChannel(channel);
    });

    return EstadoSync.idle;
  }

  Future<void> _sincronizar() async {
    if (state == EstadoSync.sincronizando) return;

    // Esperar que Supabase esté listo
    await Future.delayed(const Duration(seconds: 2));

    final results = await Connectivity().checkConnectivity();
    final online = results.any((r) => r != ConnectivityResult.none);

    if (!online) {
      state = EstadoSync.offline;
      return;
    }

    state = EstadoSync.sincronizando;
    try {
      final db = ref.read(appDatabaseProvider);
      final client = Supabase.instance.client;

      // Obtener cursor local
      final cursorStr = await db.getSyncMeta('max_cursor');
      final cursor = int.tryParse(cursorStr ?? '0') ?? 0;

      // Descargar cambios desde Supabase
      final changes = await client
          .from('catalog_changes')
          .select('cursor, medicamento_id, accion, payload')
          .gt('cursor', cursor)
          .order('cursor')
          .limit(200);

      if (changes.isEmpty) {
        // Sin cambios en catalog_changes → hacer sync completo inicial si primer arranque
        if (cursor == 0) {
          await _syncCompleto(db, client);
        }
        state = EstadoSync.actualizado;
        return;
      }

      int maxCursor = cursor;
      for (final change in changes) {
        final payload = change['payload'] as Map<String, dynamic>;
        final accion = change['accion'] as String;

        if (accion == 'upsert') {
          await _aplicarUpsert(db, payload);
        } else if (accion == 'delete') {
          final id = payload['id'] as String?;
          if (id != null) {
            await (db.delete(db.medicamentosTable)
              ..where((t) => t.id.equals(id))).go();
          }
        }

        final cur = change['cursor'];
        if (cur != null && cur > maxCursor) maxCursor = cur;
      }

      await db.setSyncMeta('max_cursor', maxCursor.toString());
      await db.setSyncMeta('ultima_sync', DateTime.now().toIso8601String());

      ref.invalidate(todosMedicamentosProvider);
      ref.invalidate(favoritosProvider);
      state = EstadoSync.actualizado;
    } catch (e, st) {
      print('SYNC ERROR: $e');
      print(st);
      state = EstadoSync.error;
    }
  }

  // Sync completo desde la tabla medicamentos (primer arranque)
  Future<void> _syncCompleto(AppDatabase db, SupabaseClient client) async {
    final rows = await client
        .from('medicamentos')
        .select('''
          id, codigo_interno, nombre_comercial, nombre_generico, categoria,
          laboratorios, descripcion, principios_activos, composicion_completa,
          concentraciones, formas_farmaceuticas, presentacion,
          vias_administracion, indicaciones_texto, indicaciones_tags,
          contraindicaciones, precauciones_advertencias, efectos_adversos,
          dosis_adultos, dosis_adultos_mayores, dosis_pediatrica, dosis_lactantes,
          foto_path, fecha_revision, actualizado_en,
          medicamento_fuentes(imagen_origen_url)
        ''')
        .eq('estado_publicacion', 'publicado')
        .eq('eliminado', false);

    for (final row in rows) {
      await _aplicarUpsert(db, row);
    }

    await db.setSyncMeta('ultima_sync', DateTime.now().toIso8601String());
  }

  Future<void> _aplicarUpsert(AppDatabase db, Map<String, dynamic> p) async {
    // Determinar URL de imagen
    String? fotoUrl;
    if (p['foto_path'] != null && (p['foto_path'] as String).isNotEmpty) {
      fotoUrl = Supabase.instance.client.storage
          .from('medicamentos-publicos')
          .getPublicUrl(p['foto_path'] as String);
    } else if (p['medicamento_fuentes'] != null) {
      final fuentes = p['medicamento_fuentes'];
      if (fuentes is Map) {
        fotoUrl = fuentes['imagen_origen_url'] as String?;
      } else if (fuentes is List && fuentes.isNotEmpty) {
        fotoUrl = fuentes.first['imagen_origen_url'] as String?;
      }
    } else if (p['foto_url_externa'] != null) {
      fotoUrl = p['foto_url_externa'] as String?;
    }

    final _toJson = (dynamic v) {
      if (v == null) return '[]';
      if (v is String) return v;
      return jsonEncode(v);
    };

    await db.upsertMedicamento(
      MedicamentosTableCompanion(
        id: Value(p['id'] as String),
        codigoInterno: Value(p['codigo_interno'] as String),
        nombreComercial: Value(p['nombre_comercial'] as String),
        nombreGenerico: Value(p['nombre_generico'] as String?),
        categoria: Value(p['categoria'] as String?),
        laboratorios: Value(_toJson(p['laboratorios'])),
        descripcion: Value(p['descripcion'] as String?),
        principiosActivos: Value(_toJson(p['principios_activos'])),
        composicionCompleta: Value(p['composicion_completa'] as String?),
        concentraciones: Value(_toJson(p['concentraciones'])),
        formasFarmaceuticas: Value(_toJson(p['formas_farmaceuticas'])),
        presentacion: Value(p['presentacion'] as String?),
        viasAdministracion: Value(_toJson(p['vias_administracion'])),
        indicacionesTexto: Value(p['indicaciones_texto'] as String?),
        indicacionesTags: Value(_toJson(p['indicaciones_tags'])),
        contraindicaciones: Value(p['contraindicaciones'] as String?),
        precaucionesAdvertencias: Value(
          p['precauciones_advertencias'] as String?,
        ),
        efectosAdversos: Value(p['efectos_adversos'] as String?),
        dosisAdultos: Value(p['dosis_adultos'] as String?),
        dosisAdultosMayores: Value(p['dosis_adultos_mayores'] as String?),
        dosisPediatrica: Value(p['dosis_pediatrica'] as String?),
        dosisLactantes: Value(p['dosis_lactantes'] as String?),
        fotoUrl: Value(fotoUrl),
        fechaRevision: Value(p['fecha_revision'] as String?),
        actualizadoEn: Value(p['actualizado_en'] as String?),
      ),
    );
  }

  void syncManual() => _sincronizar();
}

final syncProvider = NotifierProvider<SyncNotifier, EstadoSync>(
  SyncNotifier.new,
);
