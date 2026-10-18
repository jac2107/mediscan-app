import 'package:drift/drift.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/data/remote/supabase/medicamentos_remote.dart';
import 'package:medicamentos_app/domain/entities/medicamento.dart';
import 'package:medicamentos_app/domain/repositories/medicamento_repository.dart';

class MedicamentoRepositoryImpl implements MedicamentoRepository {
  final AppDatabase _db;
  final MedicamentosRemote _remote;

  MedicamentoRepositoryImpl({
    required AppDatabase db,
    required MedicamentosRemote remote,
  })  : _db = db,
        _remote = remote;

  Medicamento _fromRow(MedicamentosTableData d) => Medicamento(
        id: d.id,
        codigoInterno: d.codigoInterno,
        nombreComercial: d.nombreComercial,
        nombreGenerico: d.nombreGenerico,
        categoria: d.categoria,
        laboratorios: AppDatabase.jsonToList(d.laboratorios),
        descripcion: d.descripcion,
        principiosActivos: AppDatabase.jsonToList(d.principiosActivos),
        composicionCompleta: d.composicionCompleta,
        concentraciones: AppDatabase.jsonToList(d.concentraciones),
        formasFarmaceuticas: AppDatabase.jsonToList(d.formasFarmaceuticas),
        presentacion: d.presentacion,
        viasAdministracion: AppDatabase.jsonToList(d.viasAdministracion),
        indicacionesTexto: d.indicacionesTexto,
        indicacionesTags: AppDatabase.jsonToList(d.indicacionesTags),
        contraindicaciones: d.contraindicaciones,
        precaucionesAdvertencias: d.precaucionesAdvertencias,
        efectosAdversos: d.efectosAdversos,
        dosisAdultos: d.dosisAdultos,
        dosisAdultosMayores: d.dosisAdultosMayores,
        dosisPediatrica: d.dosisPediatrica,
        dosisLactantes: d.dosisLactantes,
        fotoUrl: d.fotoUrl,
        fechaRevision: d.fechaRevision,
        actualizadoEn: d.actualizadoEn,
        esFavorito: d.esFavorito,
      );

  @override
  Future<List<Medicamento>> getAll() async {
    final rows = await _db.getAllMedicamentos();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<Medicamento?> getById(String id) async {
    final row = await _db.getMedicamentoById(id);
    return row != null ? _fromRow(row) : null;
  }

  @override
  Future<List<Medicamento>> getFavoritos() async {
    final rows = await _db.getFavoritos();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<void> toggleFavorito(String id, bool valor) =>
      _db.toggleFavorito(id, valor);

  @override
  Future<void> sincronizar() async {
    try {
      final remotos = await _remote.getAll();
      for (final m in remotos) {
        await _db.upsertMedicamento(_toCompanion(m));
      }
    } catch (_) {
      // Sin internet — usa datos locales
    }
  }

  MedicamentosTableCompanion _toCompanion(Map<String, dynamic> m) {
    return MedicamentosTableCompanion(
      id: Value(m['id'] as String),
      codigoInterno: Value(m['codigo_interno'] as String),
      nombreComercial: Value(m['nombre_comercial'] as String),
      nombreGenerico: Value(m['nombre_generico'] as String?),
      categoria: Value(m['categoria'] as String?),
      laboratorios: Value(
          AppDatabase.listToJson(_pgArrayToList(m['laboratorios']))),
      descripcion: Value(m['descripcion'] as String?),
      principiosActivos: Value(
          AppDatabase.listToJson(_pgArrayToList(m['principios_activos']))),
      composicionCompleta: Value(m['composicion_completa'] as String?),
      concentraciones: Value(
          AppDatabase.listToJson(_pgArrayToList(m['concentraciones']))),
      formasFarmaceuticas: Value(
          AppDatabase.listToJson(_pgArrayToList(m['formas_farmaceuticas']))),
      presentacion: Value(m['presentacion'] as String?),
      viasAdministracion: Value(
          AppDatabase.listToJson(_pgArrayToList(m['vias_administracion']))),
      indicacionesTexto: Value(m['indicaciones_texto'] as String?),
      indicacionesTags: Value(
          AppDatabase.listToJson(_pgArrayToList(m['indicaciones_tags']))),
      contraindicaciones: Value(m['contraindicaciones'] as String?),
      precaucionesAdvertencias: Value(m['precauciones_advertencias'] as String?),
      efectosAdversos: Value(m['efectos_adversos'] as String?),
      dosisAdultos: Value(m['dosis_adultos'] as String?),
      dosisAdultosMayores: Value(m['dosis_adultos_mayores'] as String?),
      dosisPediatrica: Value(m['dosis_pediatrica'] as String?),
      dosisLactantes: Value(m['dosis_lactantes'] as String?),
      fotoUrl: Value(m['foto_url_externa'] as String?),
      fechaRevision: Value(m['fecha_revision'] as String?),
      actualizadoEn: Value(m['actualizado_en'] as String?),
      esFavorito: const Value(false),
    );
  }

  // El JSON viene como "{val1,val2}" desde Supabase (formato PostgreSQL array)
  static List<String> _pgArrayToList(dynamic value) {
    if (value == null) return [];
    if (value is List) return value.map((e) => e.toString()).toList();
    final s = value.toString().trim();
    if (s.startsWith('{') && s.endsWith('}')) {
      final inner = s.substring(1, s.length - 1);
      if (inner.isEmpty) return [];
      // Maneja elementos con comillas: {"val con coma","otro"}
      final result = <String>[];
      final regex = RegExp(r'"([^"]*)"|((?:[^,])+)');
      for (final m in regex.allMatches(inner)) {
        result.add((m.group(1) ?? m.group(2) ?? '').trim());
      }
      return result;
    }
    return [s];
  }
}