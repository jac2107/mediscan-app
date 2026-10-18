// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MedicamentosTableTable extends MedicamentosTable
    with TableInfo<$MedicamentosTableTable, MedicamentosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicamentosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codigoInternoMeta =
      const VerificationMeta('codigoInterno');
  @override
  late final GeneratedColumn<String> codigoInterno = GeneratedColumn<String>(
      'codigo_interno', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nombreComercialMeta =
      const VerificationMeta('nombreComercial');
  @override
  late final GeneratedColumn<String> nombreComercial = GeneratedColumn<String>(
      'nombre_comercial', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreGenericoMeta =
      const VerificationMeta('nombreGenerico');
  @override
  late final GeneratedColumn<String> nombreGenerico = GeneratedColumn<String>(
      'nombre_generico', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoriaMeta =
      const VerificationMeta('categoria');
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
      'categoria', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _laboratoriosMeta =
      const VerificationMeta('laboratorios');
  @override
  late final GeneratedColumn<String> laboratorios = GeneratedColumn<String>(
      'laboratorios', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _principiosActivosMeta =
      const VerificationMeta('principiosActivos');
  @override
  late final GeneratedColumn<String> principiosActivos =
      GeneratedColumn<String>('principios_activos', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _composicionCompletaMeta =
      const VerificationMeta('composicionCompleta');
  @override
  late final GeneratedColumn<String> composicionCompleta =
      GeneratedColumn<String>('composicion_completa', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _concentracionesMeta =
      const VerificationMeta('concentraciones');
  @override
  late final GeneratedColumn<String> concentraciones = GeneratedColumn<String>(
      'concentraciones', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _formasFarmaceuticasMeta =
      const VerificationMeta('formasFarmaceuticas');
  @override
  late final GeneratedColumn<String> formasFarmaceuticas =
      GeneratedColumn<String>('formas_farmaceuticas', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _presentacionMeta =
      const VerificationMeta('presentacion');
  @override
  late final GeneratedColumn<String> presentacion = GeneratedColumn<String>(
      'presentacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _viasAdministracionMeta =
      const VerificationMeta('viasAdministracion');
  @override
  late final GeneratedColumn<String> viasAdministracion =
      GeneratedColumn<String>('vias_administracion', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _indicacionesTextoMeta =
      const VerificationMeta('indicacionesTexto');
  @override
  late final GeneratedColumn<String> indicacionesTexto =
      GeneratedColumn<String>('indicaciones_texto', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _indicacionesTagsMeta =
      const VerificationMeta('indicacionesTags');
  @override
  late final GeneratedColumn<String> indicacionesTags = GeneratedColumn<String>(
      'indicaciones_tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _contraindicacionesMeta =
      const VerificationMeta('contraindicaciones');
  @override
  late final GeneratedColumn<String> contraindicaciones =
      GeneratedColumn<String>('contraindicaciones', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _precaucionesAdvertenciasMeta =
      const VerificationMeta('precaucionesAdvertencias');
  @override
  late final GeneratedColumn<String> precaucionesAdvertencias =
      GeneratedColumn<String>('precauciones_advertencias', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _efectosAdversosMeta =
      const VerificationMeta('efectosAdversos');
  @override
  late final GeneratedColumn<String> efectosAdversos = GeneratedColumn<String>(
      'efectos_adversos', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosisAdultosMeta =
      const VerificationMeta('dosisAdultos');
  @override
  late final GeneratedColumn<String> dosisAdultos = GeneratedColumn<String>(
      'dosis_adultos', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosisAdultosMayoresMeta =
      const VerificationMeta('dosisAdultosMayores');
  @override
  late final GeneratedColumn<String> dosisAdultosMayores =
      GeneratedColumn<String>('dosis_adultos_mayores', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosisPediatricaMeta =
      const VerificationMeta('dosisPediatrica');
  @override
  late final GeneratedColumn<String> dosisPediatrica = GeneratedColumn<String>(
      'dosis_pediatrica', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosisLactantesMeta =
      const VerificationMeta('dosisLactantes');
  @override
  late final GeneratedColumn<String> dosisLactantes = GeneratedColumn<String>(
      'dosis_lactantes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fotoUrlMeta =
      const VerificationMeta('fotoUrl');
  @override
  late final GeneratedColumn<String> fotoUrl = GeneratedColumn<String>(
      'foto_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fechaRevisionMeta =
      const VerificationMeta('fechaRevision');
  @override
  late final GeneratedColumn<String> fechaRevision = GeneratedColumn<String>(
      'fecha_revision', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _actualizadoEnMeta =
      const VerificationMeta('actualizadoEn');
  @override
  late final GeneratedColumn<String> actualizadoEn = GeneratedColumn<String>(
      'actualizado_en', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _esFavoritoMeta =
      const VerificationMeta('esFavorito');
  @override
  late final GeneratedColumn<bool> esFavorito = GeneratedColumn<bool>(
      'es_favorito', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("es_favorito" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigoInterno,
        nombreComercial,
        nombreGenerico,
        categoria,
        laboratorios,
        descripcion,
        principiosActivos,
        composicionCompleta,
        concentraciones,
        formasFarmaceuticas,
        presentacion,
        viasAdministracion,
        indicacionesTexto,
        indicacionesTags,
        contraindicaciones,
        precaucionesAdvertencias,
        efectosAdversos,
        dosisAdultos,
        dosisAdultosMayores,
        dosisPediatrica,
        dosisLactantes,
        fotoUrl,
        fechaRevision,
        actualizadoEn,
        esFavorito
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicamentos';
  @override
  VerificationContext validateIntegrity(
      Insertable<MedicamentosTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('codigo_interno')) {
      context.handle(
          _codigoInternoMeta,
          codigoInterno.isAcceptableOrUnknown(
              data['codigo_interno']!, _codigoInternoMeta));
    } else if (isInserting) {
      context.missing(_codigoInternoMeta);
    }
    if (data.containsKey('nombre_comercial')) {
      context.handle(
          _nombreComercialMeta,
          nombreComercial.isAcceptableOrUnknown(
              data['nombre_comercial']!, _nombreComercialMeta));
    } else if (isInserting) {
      context.missing(_nombreComercialMeta);
    }
    if (data.containsKey('nombre_generico')) {
      context.handle(
          _nombreGenericoMeta,
          nombreGenerico.isAcceptableOrUnknown(
              data['nombre_generico']!, _nombreGenericoMeta));
    }
    if (data.containsKey('categoria')) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta));
    }
    if (data.containsKey('laboratorios')) {
      context.handle(
          _laboratoriosMeta,
          laboratorios.isAcceptableOrUnknown(
              data['laboratorios']!, _laboratoriosMeta));
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    if (data.containsKey('principios_activos')) {
      context.handle(
          _principiosActivosMeta,
          principiosActivos.isAcceptableOrUnknown(
              data['principios_activos']!, _principiosActivosMeta));
    }
    if (data.containsKey('composicion_completa')) {
      context.handle(
          _composicionCompletaMeta,
          composicionCompleta.isAcceptableOrUnknown(
              data['composicion_completa']!, _composicionCompletaMeta));
    }
    if (data.containsKey('concentraciones')) {
      context.handle(
          _concentracionesMeta,
          concentraciones.isAcceptableOrUnknown(
              data['concentraciones']!, _concentracionesMeta));
    }
    if (data.containsKey('formas_farmaceuticas')) {
      context.handle(
          _formasFarmaceuticasMeta,
          formasFarmaceuticas.isAcceptableOrUnknown(
              data['formas_farmaceuticas']!, _formasFarmaceuticasMeta));
    }
    if (data.containsKey('presentacion')) {
      context.handle(
          _presentacionMeta,
          presentacion.isAcceptableOrUnknown(
              data['presentacion']!, _presentacionMeta));
    }
    if (data.containsKey('vias_administracion')) {
      context.handle(
          _viasAdministracionMeta,
          viasAdministracion.isAcceptableOrUnknown(
              data['vias_administracion']!, _viasAdministracionMeta));
    }
    if (data.containsKey('indicaciones_texto')) {
      context.handle(
          _indicacionesTextoMeta,
          indicacionesTexto.isAcceptableOrUnknown(
              data['indicaciones_texto']!, _indicacionesTextoMeta));
    }
    if (data.containsKey('indicaciones_tags')) {
      context.handle(
          _indicacionesTagsMeta,
          indicacionesTags.isAcceptableOrUnknown(
              data['indicaciones_tags']!, _indicacionesTagsMeta));
    }
    if (data.containsKey('contraindicaciones')) {
      context.handle(
          _contraindicacionesMeta,
          contraindicaciones.isAcceptableOrUnknown(
              data['contraindicaciones']!, _contraindicacionesMeta));
    }
    if (data.containsKey('precauciones_advertencias')) {
      context.handle(
          _precaucionesAdvertenciasMeta,
          precaucionesAdvertencias.isAcceptableOrUnknown(
              data['precauciones_advertencias']!,
              _precaucionesAdvertenciasMeta));
    }
    if (data.containsKey('efectos_adversos')) {
      context.handle(
          _efectosAdversosMeta,
          efectosAdversos.isAcceptableOrUnknown(
              data['efectos_adversos']!, _efectosAdversosMeta));
    }
    if (data.containsKey('dosis_adultos')) {
      context.handle(
          _dosisAdultosMeta,
          dosisAdultos.isAcceptableOrUnknown(
              data['dosis_adultos']!, _dosisAdultosMeta));
    }
    if (data.containsKey('dosis_adultos_mayores')) {
      context.handle(
          _dosisAdultosMayoresMeta,
          dosisAdultosMayores.isAcceptableOrUnknown(
              data['dosis_adultos_mayores']!, _dosisAdultosMayoresMeta));
    }
    if (data.containsKey('dosis_pediatrica')) {
      context.handle(
          _dosisPediatricaMeta,
          dosisPediatrica.isAcceptableOrUnknown(
              data['dosis_pediatrica']!, _dosisPediatricaMeta));
    }
    if (data.containsKey('dosis_lactantes')) {
      context.handle(
          _dosisLactantesMeta,
          dosisLactantes.isAcceptableOrUnknown(
              data['dosis_lactantes']!, _dosisLactantesMeta));
    }
    if (data.containsKey('foto_url')) {
      context.handle(_fotoUrlMeta,
          fotoUrl.isAcceptableOrUnknown(data['foto_url']!, _fotoUrlMeta));
    }
    if (data.containsKey('fecha_revision')) {
      context.handle(
          _fechaRevisionMeta,
          fechaRevision.isAcceptableOrUnknown(
              data['fecha_revision']!, _fechaRevisionMeta));
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
          _actualizadoEnMeta,
          actualizadoEn.isAcceptableOrUnknown(
              data['actualizado_en']!, _actualizadoEnMeta));
    }
    if (data.containsKey('es_favorito')) {
      context.handle(
          _esFavoritoMeta,
          esFavorito.isAcceptableOrUnknown(
              data['es_favorito']!, _esFavoritoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicamentosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicamentosTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      codigoInterno: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo_interno'])!,
      nombreComercial: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nombre_comercial'])!,
      nombreGenerico: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre_generico']),
      categoria: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}categoria']),
      laboratorios: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}laboratorios'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
      principiosActivos: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}principios_activos'])!,
      composicionCompleta: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}composicion_completa']),
      concentraciones: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}concentraciones'])!,
      formasFarmaceuticas: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}formas_farmaceuticas'])!,
      presentacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}presentacion']),
      viasAdministracion: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}vias_administracion'])!,
      indicacionesTexto: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}indicaciones_texto']),
      indicacionesTags: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}indicaciones_tags'])!,
      contraindicaciones: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}contraindicaciones']),
      precaucionesAdvertencias: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}precauciones_advertencias']),
      efectosAdversos: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}efectos_adversos']),
      dosisAdultos: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosis_adultos']),
      dosisAdultosMayores: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}dosis_adultos_mayores']),
      dosisPediatrica: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}dosis_pediatrica']),
      dosisLactantes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosis_lactantes']),
      fotoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foto_url']),
      fechaRevision: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fecha_revision']),
      actualizadoEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}actualizado_en']),
      esFavorito: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_favorito'])!,
    );
  }

  @override
  $MedicamentosTableTable createAlias(String alias) {
    return $MedicamentosTableTable(attachedDatabase, alias);
  }
}

class MedicamentosTableData extends DataClass
    implements Insertable<MedicamentosTableData> {
  final String id;
  final String codigoInterno;
  final String nombreComercial;
  final String? nombreGenerico;
  final String? categoria;
  final String laboratorios;
  final String? descripcion;
  final String principiosActivos;
  final String? composicionCompleta;
  final String concentraciones;
  final String formasFarmaceuticas;
  final String? presentacion;
  final String viasAdministracion;
  final String? indicacionesTexto;
  final String indicacionesTags;
  final String? contraindicaciones;
  final String? precaucionesAdvertencias;
  final String? efectosAdversos;
  final String? dosisAdultos;
  final String? dosisAdultosMayores;
  final String? dosisPediatrica;
  final String? dosisLactantes;
  final String? fotoUrl;
  final String? fechaRevision;
  final String? actualizadoEn;
  final bool esFavorito;
  const MedicamentosTableData(
      {required this.id,
      required this.codigoInterno,
      required this.nombreComercial,
      this.nombreGenerico,
      this.categoria,
      required this.laboratorios,
      this.descripcion,
      required this.principiosActivos,
      this.composicionCompleta,
      required this.concentraciones,
      required this.formasFarmaceuticas,
      this.presentacion,
      required this.viasAdministracion,
      this.indicacionesTexto,
      required this.indicacionesTags,
      this.contraindicaciones,
      this.precaucionesAdvertencias,
      this.efectosAdversos,
      this.dosisAdultos,
      this.dosisAdultosMayores,
      this.dosisPediatrica,
      this.dosisLactantes,
      this.fotoUrl,
      this.fechaRevision,
      this.actualizadoEn,
      required this.esFavorito});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['codigo_interno'] = Variable<String>(codigoInterno);
    map['nombre_comercial'] = Variable<String>(nombreComercial);
    if (!nullToAbsent || nombreGenerico != null) {
      map['nombre_generico'] = Variable<String>(nombreGenerico);
    }
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    map['laboratorios'] = Variable<String>(laboratorios);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['principios_activos'] = Variable<String>(principiosActivos);
    if (!nullToAbsent || composicionCompleta != null) {
      map['composicion_completa'] = Variable<String>(composicionCompleta);
    }
    map['concentraciones'] = Variable<String>(concentraciones);
    map['formas_farmaceuticas'] = Variable<String>(formasFarmaceuticas);
    if (!nullToAbsent || presentacion != null) {
      map['presentacion'] = Variable<String>(presentacion);
    }
    map['vias_administracion'] = Variable<String>(viasAdministracion);
    if (!nullToAbsent || indicacionesTexto != null) {
      map['indicaciones_texto'] = Variable<String>(indicacionesTexto);
    }
    map['indicaciones_tags'] = Variable<String>(indicacionesTags);
    if (!nullToAbsent || contraindicaciones != null) {
      map['contraindicaciones'] = Variable<String>(contraindicaciones);
    }
    if (!nullToAbsent || precaucionesAdvertencias != null) {
      map['precauciones_advertencias'] =
          Variable<String>(precaucionesAdvertencias);
    }
    if (!nullToAbsent || efectosAdversos != null) {
      map['efectos_adversos'] = Variable<String>(efectosAdversos);
    }
    if (!nullToAbsent || dosisAdultos != null) {
      map['dosis_adultos'] = Variable<String>(dosisAdultos);
    }
    if (!nullToAbsent || dosisAdultosMayores != null) {
      map['dosis_adultos_mayores'] = Variable<String>(dosisAdultosMayores);
    }
    if (!nullToAbsent || dosisPediatrica != null) {
      map['dosis_pediatrica'] = Variable<String>(dosisPediatrica);
    }
    if (!nullToAbsent || dosisLactantes != null) {
      map['dosis_lactantes'] = Variable<String>(dosisLactantes);
    }
    if (!nullToAbsent || fotoUrl != null) {
      map['foto_url'] = Variable<String>(fotoUrl);
    }
    if (!nullToAbsent || fechaRevision != null) {
      map['fecha_revision'] = Variable<String>(fechaRevision);
    }
    if (!nullToAbsent || actualizadoEn != null) {
      map['actualizado_en'] = Variable<String>(actualizadoEn);
    }
    map['es_favorito'] = Variable<bool>(esFavorito);
    return map;
  }

  MedicamentosTableCompanion toCompanion(bool nullToAbsent) {
    return MedicamentosTableCompanion(
      id: Value(id),
      codigoInterno: Value(codigoInterno),
      nombreComercial: Value(nombreComercial),
      nombreGenerico: nombreGenerico == null && nullToAbsent
          ? const Value.absent()
          : Value(nombreGenerico),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      laboratorios: Value(laboratorios),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      principiosActivos: Value(principiosActivos),
      composicionCompleta: composicionCompleta == null && nullToAbsent
          ? const Value.absent()
          : Value(composicionCompleta),
      concentraciones: Value(concentraciones),
      formasFarmaceuticas: Value(formasFarmaceuticas),
      presentacion: presentacion == null && nullToAbsent
          ? const Value.absent()
          : Value(presentacion),
      viasAdministracion: Value(viasAdministracion),
      indicacionesTexto: indicacionesTexto == null && nullToAbsent
          ? const Value.absent()
          : Value(indicacionesTexto),
      indicacionesTags: Value(indicacionesTags),
      contraindicaciones: contraindicaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(contraindicaciones),
      precaucionesAdvertencias: precaucionesAdvertencias == null && nullToAbsent
          ? const Value.absent()
          : Value(precaucionesAdvertencias),
      efectosAdversos: efectosAdversos == null && nullToAbsent
          ? const Value.absent()
          : Value(efectosAdversos),
      dosisAdultos: dosisAdultos == null && nullToAbsent
          ? const Value.absent()
          : Value(dosisAdultos),
      dosisAdultosMayores: dosisAdultosMayores == null && nullToAbsent
          ? const Value.absent()
          : Value(dosisAdultosMayores),
      dosisPediatrica: dosisPediatrica == null && nullToAbsent
          ? const Value.absent()
          : Value(dosisPediatrica),
      dosisLactantes: dosisLactantes == null && nullToAbsent
          ? const Value.absent()
          : Value(dosisLactantes),
      fotoUrl: fotoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoUrl),
      fechaRevision: fechaRevision == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaRevision),
      actualizadoEn: actualizadoEn == null && nullToAbsent
          ? const Value.absent()
          : Value(actualizadoEn),
      esFavorito: Value(esFavorito),
    );
  }

  factory MedicamentosTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicamentosTableData(
      id: serializer.fromJson<String>(json['id']),
      codigoInterno: serializer.fromJson<String>(json['codigoInterno']),
      nombreComercial: serializer.fromJson<String>(json['nombreComercial']),
      nombreGenerico: serializer.fromJson<String?>(json['nombreGenerico']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      laboratorios: serializer.fromJson<String>(json['laboratorios']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      principiosActivos: serializer.fromJson<String>(json['principiosActivos']),
      composicionCompleta:
          serializer.fromJson<String?>(json['composicionCompleta']),
      concentraciones: serializer.fromJson<String>(json['concentraciones']),
      formasFarmaceuticas:
          serializer.fromJson<String>(json['formasFarmaceuticas']),
      presentacion: serializer.fromJson<String?>(json['presentacion']),
      viasAdministracion:
          serializer.fromJson<String>(json['viasAdministracion']),
      indicacionesTexto:
          serializer.fromJson<String?>(json['indicacionesTexto']),
      indicacionesTags: serializer.fromJson<String>(json['indicacionesTags']),
      contraindicaciones:
          serializer.fromJson<String?>(json['contraindicaciones']),
      precaucionesAdvertencias:
          serializer.fromJson<String?>(json['precaucionesAdvertencias']),
      efectosAdversos: serializer.fromJson<String?>(json['efectosAdversos']),
      dosisAdultos: serializer.fromJson<String?>(json['dosisAdultos']),
      dosisAdultosMayores:
          serializer.fromJson<String?>(json['dosisAdultosMayores']),
      dosisPediatrica: serializer.fromJson<String?>(json['dosisPediatrica']),
      dosisLactantes: serializer.fromJson<String?>(json['dosisLactantes']),
      fotoUrl: serializer.fromJson<String?>(json['fotoUrl']),
      fechaRevision: serializer.fromJson<String?>(json['fechaRevision']),
      actualizadoEn: serializer.fromJson<String?>(json['actualizadoEn']),
      esFavorito: serializer.fromJson<bool>(json['esFavorito']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'codigoInterno': serializer.toJson<String>(codigoInterno),
      'nombreComercial': serializer.toJson<String>(nombreComercial),
      'nombreGenerico': serializer.toJson<String?>(nombreGenerico),
      'categoria': serializer.toJson<String?>(categoria),
      'laboratorios': serializer.toJson<String>(laboratorios),
      'descripcion': serializer.toJson<String?>(descripcion),
      'principiosActivos': serializer.toJson<String>(principiosActivos),
      'composicionCompleta': serializer.toJson<String?>(composicionCompleta),
      'concentraciones': serializer.toJson<String>(concentraciones),
      'formasFarmaceuticas': serializer.toJson<String>(formasFarmaceuticas),
      'presentacion': serializer.toJson<String?>(presentacion),
      'viasAdministracion': serializer.toJson<String>(viasAdministracion),
      'indicacionesTexto': serializer.toJson<String?>(indicacionesTexto),
      'indicacionesTags': serializer.toJson<String>(indicacionesTags),
      'contraindicaciones': serializer.toJson<String?>(contraindicaciones),
      'precaucionesAdvertencias':
          serializer.toJson<String?>(precaucionesAdvertencias),
      'efectosAdversos': serializer.toJson<String?>(efectosAdversos),
      'dosisAdultos': serializer.toJson<String?>(dosisAdultos),
      'dosisAdultosMayores': serializer.toJson<String?>(dosisAdultosMayores),
      'dosisPediatrica': serializer.toJson<String?>(dosisPediatrica),
      'dosisLactantes': serializer.toJson<String?>(dosisLactantes),
      'fotoUrl': serializer.toJson<String?>(fotoUrl),
      'fechaRevision': serializer.toJson<String?>(fechaRevision),
      'actualizadoEn': serializer.toJson<String?>(actualizadoEn),
      'esFavorito': serializer.toJson<bool>(esFavorito),
    };
  }

  MedicamentosTableData copyWith(
          {String? id,
          String? codigoInterno,
          String? nombreComercial,
          Value<String?> nombreGenerico = const Value.absent(),
          Value<String?> categoria = const Value.absent(),
          String? laboratorios,
          Value<String?> descripcion = const Value.absent(),
          String? principiosActivos,
          Value<String?> composicionCompleta = const Value.absent(),
          String? concentraciones,
          String? formasFarmaceuticas,
          Value<String?> presentacion = const Value.absent(),
          String? viasAdministracion,
          Value<String?> indicacionesTexto = const Value.absent(),
          String? indicacionesTags,
          Value<String?> contraindicaciones = const Value.absent(),
          Value<String?> precaucionesAdvertencias = const Value.absent(),
          Value<String?> efectosAdversos = const Value.absent(),
          Value<String?> dosisAdultos = const Value.absent(),
          Value<String?> dosisAdultosMayores = const Value.absent(),
          Value<String?> dosisPediatrica = const Value.absent(),
          Value<String?> dosisLactantes = const Value.absent(),
          Value<String?> fotoUrl = const Value.absent(),
          Value<String?> fechaRevision = const Value.absent(),
          Value<String?> actualizadoEn = const Value.absent(),
          bool? esFavorito}) =>
      MedicamentosTableData(
        id: id ?? this.id,
        codigoInterno: codigoInterno ?? this.codigoInterno,
        nombreComercial: nombreComercial ?? this.nombreComercial,
        nombreGenerico:
            nombreGenerico.present ? nombreGenerico.value : this.nombreGenerico,
        categoria: categoria.present ? categoria.value : this.categoria,
        laboratorios: laboratorios ?? this.laboratorios,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
        principiosActivos: principiosActivos ?? this.principiosActivos,
        composicionCompleta: composicionCompleta.present
            ? composicionCompleta.value
            : this.composicionCompleta,
        concentraciones: concentraciones ?? this.concentraciones,
        formasFarmaceuticas: formasFarmaceuticas ?? this.formasFarmaceuticas,
        presentacion:
            presentacion.present ? presentacion.value : this.presentacion,
        viasAdministracion: viasAdministracion ?? this.viasAdministracion,
        indicacionesTexto: indicacionesTexto.present
            ? indicacionesTexto.value
            : this.indicacionesTexto,
        indicacionesTags: indicacionesTags ?? this.indicacionesTags,
        contraindicaciones: contraindicaciones.present
            ? contraindicaciones.value
            : this.contraindicaciones,
        precaucionesAdvertencias: precaucionesAdvertencias.present
            ? precaucionesAdvertencias.value
            : this.precaucionesAdvertencias,
        efectosAdversos: efectosAdversos.present
            ? efectosAdversos.value
            : this.efectosAdversos,
        dosisAdultos:
            dosisAdultos.present ? dosisAdultos.value : this.dosisAdultos,
        dosisAdultosMayores: dosisAdultosMayores.present
            ? dosisAdultosMayores.value
            : this.dosisAdultosMayores,
        dosisPediatrica: dosisPediatrica.present
            ? dosisPediatrica.value
            : this.dosisPediatrica,
        dosisLactantes:
            dosisLactantes.present ? dosisLactantes.value : this.dosisLactantes,
        fotoUrl: fotoUrl.present ? fotoUrl.value : this.fotoUrl,
        fechaRevision:
            fechaRevision.present ? fechaRevision.value : this.fechaRevision,
        actualizadoEn:
            actualizadoEn.present ? actualizadoEn.value : this.actualizadoEn,
        esFavorito: esFavorito ?? this.esFavorito,
      );
  MedicamentosTableData copyWithCompanion(MedicamentosTableCompanion data) {
    return MedicamentosTableData(
      id: data.id.present ? data.id.value : this.id,
      codigoInterno: data.codigoInterno.present
          ? data.codigoInterno.value
          : this.codigoInterno,
      nombreComercial: data.nombreComercial.present
          ? data.nombreComercial.value
          : this.nombreComercial,
      nombreGenerico: data.nombreGenerico.present
          ? data.nombreGenerico.value
          : this.nombreGenerico,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      laboratorios: data.laboratorios.present
          ? data.laboratorios.value
          : this.laboratorios,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      principiosActivos: data.principiosActivos.present
          ? data.principiosActivos.value
          : this.principiosActivos,
      composicionCompleta: data.composicionCompleta.present
          ? data.composicionCompleta.value
          : this.composicionCompleta,
      concentraciones: data.concentraciones.present
          ? data.concentraciones.value
          : this.concentraciones,
      formasFarmaceuticas: data.formasFarmaceuticas.present
          ? data.formasFarmaceuticas.value
          : this.formasFarmaceuticas,
      presentacion: data.presentacion.present
          ? data.presentacion.value
          : this.presentacion,
      viasAdministracion: data.viasAdministracion.present
          ? data.viasAdministracion.value
          : this.viasAdministracion,
      indicacionesTexto: data.indicacionesTexto.present
          ? data.indicacionesTexto.value
          : this.indicacionesTexto,
      indicacionesTags: data.indicacionesTags.present
          ? data.indicacionesTags.value
          : this.indicacionesTags,
      contraindicaciones: data.contraindicaciones.present
          ? data.contraindicaciones.value
          : this.contraindicaciones,
      precaucionesAdvertencias: data.precaucionesAdvertencias.present
          ? data.precaucionesAdvertencias.value
          : this.precaucionesAdvertencias,
      efectosAdversos: data.efectosAdversos.present
          ? data.efectosAdversos.value
          : this.efectosAdversos,
      dosisAdultos: data.dosisAdultos.present
          ? data.dosisAdultos.value
          : this.dosisAdultos,
      dosisAdultosMayores: data.dosisAdultosMayores.present
          ? data.dosisAdultosMayores.value
          : this.dosisAdultosMayores,
      dosisPediatrica: data.dosisPediatrica.present
          ? data.dosisPediatrica.value
          : this.dosisPediatrica,
      dosisLactantes: data.dosisLactantes.present
          ? data.dosisLactantes.value
          : this.dosisLactantes,
      fotoUrl: data.fotoUrl.present ? data.fotoUrl.value : this.fotoUrl,
      fechaRevision: data.fechaRevision.present
          ? data.fechaRevision.value
          : this.fechaRevision,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
      esFavorito:
          data.esFavorito.present ? data.esFavorito.value : this.esFavorito,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicamentosTableData(')
          ..write('id: $id, ')
          ..write('codigoInterno: $codigoInterno, ')
          ..write('nombreComercial: $nombreComercial, ')
          ..write('nombreGenerico: $nombreGenerico, ')
          ..write('categoria: $categoria, ')
          ..write('laboratorios: $laboratorios, ')
          ..write('descripcion: $descripcion, ')
          ..write('principiosActivos: $principiosActivos, ')
          ..write('composicionCompleta: $composicionCompleta, ')
          ..write('concentraciones: $concentraciones, ')
          ..write('formasFarmaceuticas: $formasFarmaceuticas, ')
          ..write('presentacion: $presentacion, ')
          ..write('viasAdministracion: $viasAdministracion, ')
          ..write('indicacionesTexto: $indicacionesTexto, ')
          ..write('indicacionesTags: $indicacionesTags, ')
          ..write('contraindicaciones: $contraindicaciones, ')
          ..write('precaucionesAdvertencias: $precaucionesAdvertencias, ')
          ..write('efectosAdversos: $efectosAdversos, ')
          ..write('dosisAdultos: $dosisAdultos, ')
          ..write('dosisAdultosMayores: $dosisAdultosMayores, ')
          ..write('dosisPediatrica: $dosisPediatrica, ')
          ..write('dosisLactantes: $dosisLactantes, ')
          ..write('fotoUrl: $fotoUrl, ')
          ..write('fechaRevision: $fechaRevision, ')
          ..write('actualizadoEn: $actualizadoEn, ')
          ..write('esFavorito: $esFavorito')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        codigoInterno,
        nombreComercial,
        nombreGenerico,
        categoria,
        laboratorios,
        descripcion,
        principiosActivos,
        composicionCompleta,
        concentraciones,
        formasFarmaceuticas,
        presentacion,
        viasAdministracion,
        indicacionesTexto,
        indicacionesTags,
        contraindicaciones,
        precaucionesAdvertencias,
        efectosAdversos,
        dosisAdultos,
        dosisAdultosMayores,
        dosisPediatrica,
        dosisLactantes,
        fotoUrl,
        fechaRevision,
        actualizadoEn,
        esFavorito
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicamentosTableData &&
          other.id == this.id &&
          other.codigoInterno == this.codigoInterno &&
          other.nombreComercial == this.nombreComercial &&
          other.nombreGenerico == this.nombreGenerico &&
          other.categoria == this.categoria &&
          other.laboratorios == this.laboratorios &&
          other.descripcion == this.descripcion &&
          other.principiosActivos == this.principiosActivos &&
          other.composicionCompleta == this.composicionCompleta &&
          other.concentraciones == this.concentraciones &&
          other.formasFarmaceuticas == this.formasFarmaceuticas &&
          other.presentacion == this.presentacion &&
          other.viasAdministracion == this.viasAdministracion &&
          other.indicacionesTexto == this.indicacionesTexto &&
          other.indicacionesTags == this.indicacionesTags &&
          other.contraindicaciones == this.contraindicaciones &&
          other.precaucionesAdvertencias == this.precaucionesAdvertencias &&
          other.efectosAdversos == this.efectosAdversos &&
          other.dosisAdultos == this.dosisAdultos &&
          other.dosisAdultosMayores == this.dosisAdultosMayores &&
          other.dosisPediatrica == this.dosisPediatrica &&
          other.dosisLactantes == this.dosisLactantes &&
          other.fotoUrl == this.fotoUrl &&
          other.fechaRevision == this.fechaRevision &&
          other.actualizadoEn == this.actualizadoEn &&
          other.esFavorito == this.esFavorito);
}

class MedicamentosTableCompanion
    extends UpdateCompanion<MedicamentosTableData> {
  final Value<String> id;
  final Value<String> codigoInterno;
  final Value<String> nombreComercial;
  final Value<String?> nombreGenerico;
  final Value<String?> categoria;
  final Value<String> laboratorios;
  final Value<String?> descripcion;
  final Value<String> principiosActivos;
  final Value<String?> composicionCompleta;
  final Value<String> concentraciones;
  final Value<String> formasFarmaceuticas;
  final Value<String?> presentacion;
  final Value<String> viasAdministracion;
  final Value<String?> indicacionesTexto;
  final Value<String> indicacionesTags;
  final Value<String?> contraindicaciones;
  final Value<String?> precaucionesAdvertencias;
  final Value<String?> efectosAdversos;
  final Value<String?> dosisAdultos;
  final Value<String?> dosisAdultosMayores;
  final Value<String?> dosisPediatrica;
  final Value<String?> dosisLactantes;
  final Value<String?> fotoUrl;
  final Value<String?> fechaRevision;
  final Value<String?> actualizadoEn;
  final Value<bool> esFavorito;
  final Value<int> rowid;
  const MedicamentosTableCompanion({
    this.id = const Value.absent(),
    this.codigoInterno = const Value.absent(),
    this.nombreComercial = const Value.absent(),
    this.nombreGenerico = const Value.absent(),
    this.categoria = const Value.absent(),
    this.laboratorios = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.principiosActivos = const Value.absent(),
    this.composicionCompleta = const Value.absent(),
    this.concentraciones = const Value.absent(),
    this.formasFarmaceuticas = const Value.absent(),
    this.presentacion = const Value.absent(),
    this.viasAdministracion = const Value.absent(),
    this.indicacionesTexto = const Value.absent(),
    this.indicacionesTags = const Value.absent(),
    this.contraindicaciones = const Value.absent(),
    this.precaucionesAdvertencias = const Value.absent(),
    this.efectosAdversos = const Value.absent(),
    this.dosisAdultos = const Value.absent(),
    this.dosisAdultosMayores = const Value.absent(),
    this.dosisPediatrica = const Value.absent(),
    this.dosisLactantes = const Value.absent(),
    this.fotoUrl = const Value.absent(),
    this.fechaRevision = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
    this.esFavorito = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicamentosTableCompanion.insert({
    required String id,
    required String codigoInterno,
    required String nombreComercial,
    this.nombreGenerico = const Value.absent(),
    this.categoria = const Value.absent(),
    this.laboratorios = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.principiosActivos = const Value.absent(),
    this.composicionCompleta = const Value.absent(),
    this.concentraciones = const Value.absent(),
    this.formasFarmaceuticas = const Value.absent(),
    this.presentacion = const Value.absent(),
    this.viasAdministracion = const Value.absent(),
    this.indicacionesTexto = const Value.absent(),
    this.indicacionesTags = const Value.absent(),
    this.contraindicaciones = const Value.absent(),
    this.precaucionesAdvertencias = const Value.absent(),
    this.efectosAdversos = const Value.absent(),
    this.dosisAdultos = const Value.absent(),
    this.dosisAdultosMayores = const Value.absent(),
    this.dosisPediatrica = const Value.absent(),
    this.dosisLactantes = const Value.absent(),
    this.fotoUrl = const Value.absent(),
    this.fechaRevision = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
    this.esFavorito = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        codigoInterno = Value(codigoInterno),
        nombreComercial = Value(nombreComercial);
  static Insertable<MedicamentosTableData> custom({
    Expression<String>? id,
    Expression<String>? codigoInterno,
    Expression<String>? nombreComercial,
    Expression<String>? nombreGenerico,
    Expression<String>? categoria,
    Expression<String>? laboratorios,
    Expression<String>? descripcion,
    Expression<String>? principiosActivos,
    Expression<String>? composicionCompleta,
    Expression<String>? concentraciones,
    Expression<String>? formasFarmaceuticas,
    Expression<String>? presentacion,
    Expression<String>? viasAdministracion,
    Expression<String>? indicacionesTexto,
    Expression<String>? indicacionesTags,
    Expression<String>? contraindicaciones,
    Expression<String>? precaucionesAdvertencias,
    Expression<String>? efectosAdversos,
    Expression<String>? dosisAdultos,
    Expression<String>? dosisAdultosMayores,
    Expression<String>? dosisPediatrica,
    Expression<String>? dosisLactantes,
    Expression<String>? fotoUrl,
    Expression<String>? fechaRevision,
    Expression<String>? actualizadoEn,
    Expression<bool>? esFavorito,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigoInterno != null) 'codigo_interno': codigoInterno,
      if (nombreComercial != null) 'nombre_comercial': nombreComercial,
      if (nombreGenerico != null) 'nombre_generico': nombreGenerico,
      if (categoria != null) 'categoria': categoria,
      if (laboratorios != null) 'laboratorios': laboratorios,
      if (descripcion != null) 'descripcion': descripcion,
      if (principiosActivos != null) 'principios_activos': principiosActivos,
      if (composicionCompleta != null)
        'composicion_completa': composicionCompleta,
      if (concentraciones != null) 'concentraciones': concentraciones,
      if (formasFarmaceuticas != null)
        'formas_farmaceuticas': formasFarmaceuticas,
      if (presentacion != null) 'presentacion': presentacion,
      if (viasAdministracion != null) 'vias_administracion': viasAdministracion,
      if (indicacionesTexto != null) 'indicaciones_texto': indicacionesTexto,
      if (indicacionesTags != null) 'indicaciones_tags': indicacionesTags,
      if (contraindicaciones != null) 'contraindicaciones': contraindicaciones,
      if (precaucionesAdvertencias != null)
        'precauciones_advertencias': precaucionesAdvertencias,
      if (efectosAdversos != null) 'efectos_adversos': efectosAdversos,
      if (dosisAdultos != null) 'dosis_adultos': dosisAdultos,
      if (dosisAdultosMayores != null)
        'dosis_adultos_mayores': dosisAdultosMayores,
      if (dosisPediatrica != null) 'dosis_pediatrica': dosisPediatrica,
      if (dosisLactantes != null) 'dosis_lactantes': dosisLactantes,
      if (fotoUrl != null) 'foto_url': fotoUrl,
      if (fechaRevision != null) 'fecha_revision': fechaRevision,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
      if (esFavorito != null) 'es_favorito': esFavorito,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicamentosTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? codigoInterno,
      Value<String>? nombreComercial,
      Value<String?>? nombreGenerico,
      Value<String?>? categoria,
      Value<String>? laboratorios,
      Value<String?>? descripcion,
      Value<String>? principiosActivos,
      Value<String?>? composicionCompleta,
      Value<String>? concentraciones,
      Value<String>? formasFarmaceuticas,
      Value<String?>? presentacion,
      Value<String>? viasAdministracion,
      Value<String?>? indicacionesTexto,
      Value<String>? indicacionesTags,
      Value<String?>? contraindicaciones,
      Value<String?>? precaucionesAdvertencias,
      Value<String?>? efectosAdversos,
      Value<String?>? dosisAdultos,
      Value<String?>? dosisAdultosMayores,
      Value<String?>? dosisPediatrica,
      Value<String?>? dosisLactantes,
      Value<String?>? fotoUrl,
      Value<String?>? fechaRevision,
      Value<String?>? actualizadoEn,
      Value<bool>? esFavorito,
      Value<int>? rowid}) {
    return MedicamentosTableCompanion(
      id: id ?? this.id,
      codigoInterno: codigoInterno ?? this.codigoInterno,
      nombreComercial: nombreComercial ?? this.nombreComercial,
      nombreGenerico: nombreGenerico ?? this.nombreGenerico,
      categoria: categoria ?? this.categoria,
      laboratorios: laboratorios ?? this.laboratorios,
      descripcion: descripcion ?? this.descripcion,
      principiosActivos: principiosActivos ?? this.principiosActivos,
      composicionCompleta: composicionCompleta ?? this.composicionCompleta,
      concentraciones: concentraciones ?? this.concentraciones,
      formasFarmaceuticas: formasFarmaceuticas ?? this.formasFarmaceuticas,
      presentacion: presentacion ?? this.presentacion,
      viasAdministracion: viasAdministracion ?? this.viasAdministracion,
      indicacionesTexto: indicacionesTexto ?? this.indicacionesTexto,
      indicacionesTags: indicacionesTags ?? this.indicacionesTags,
      contraindicaciones: contraindicaciones ?? this.contraindicaciones,
      precaucionesAdvertencias:
          precaucionesAdvertencias ?? this.precaucionesAdvertencias,
      efectosAdversos: efectosAdversos ?? this.efectosAdversos,
      dosisAdultos: dosisAdultos ?? this.dosisAdultos,
      dosisAdultosMayores: dosisAdultosMayores ?? this.dosisAdultosMayores,
      dosisPediatrica: dosisPediatrica ?? this.dosisPediatrica,
      dosisLactantes: dosisLactantes ?? this.dosisLactantes,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      fechaRevision: fechaRevision ?? this.fechaRevision,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
      esFavorito: esFavorito ?? this.esFavorito,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (codigoInterno.present) {
      map['codigo_interno'] = Variable<String>(codigoInterno.value);
    }
    if (nombreComercial.present) {
      map['nombre_comercial'] = Variable<String>(nombreComercial.value);
    }
    if (nombreGenerico.present) {
      map['nombre_generico'] = Variable<String>(nombreGenerico.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (laboratorios.present) {
      map['laboratorios'] = Variable<String>(laboratorios.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (principiosActivos.present) {
      map['principios_activos'] = Variable<String>(principiosActivos.value);
    }
    if (composicionCompleta.present) {
      map['composicion_completa'] = Variable<String>(composicionCompleta.value);
    }
    if (concentraciones.present) {
      map['concentraciones'] = Variable<String>(concentraciones.value);
    }
    if (formasFarmaceuticas.present) {
      map['formas_farmaceuticas'] = Variable<String>(formasFarmaceuticas.value);
    }
    if (presentacion.present) {
      map['presentacion'] = Variable<String>(presentacion.value);
    }
    if (viasAdministracion.present) {
      map['vias_administracion'] = Variable<String>(viasAdministracion.value);
    }
    if (indicacionesTexto.present) {
      map['indicaciones_texto'] = Variable<String>(indicacionesTexto.value);
    }
    if (indicacionesTags.present) {
      map['indicaciones_tags'] = Variable<String>(indicacionesTags.value);
    }
    if (contraindicaciones.present) {
      map['contraindicaciones'] = Variable<String>(contraindicaciones.value);
    }
    if (precaucionesAdvertencias.present) {
      map['precauciones_advertencias'] =
          Variable<String>(precaucionesAdvertencias.value);
    }
    if (efectosAdversos.present) {
      map['efectos_adversos'] = Variable<String>(efectosAdversos.value);
    }
    if (dosisAdultos.present) {
      map['dosis_adultos'] = Variable<String>(dosisAdultos.value);
    }
    if (dosisAdultosMayores.present) {
      map['dosis_adultos_mayores'] =
          Variable<String>(dosisAdultosMayores.value);
    }
    if (dosisPediatrica.present) {
      map['dosis_pediatrica'] = Variable<String>(dosisPediatrica.value);
    }
    if (dosisLactantes.present) {
      map['dosis_lactantes'] = Variable<String>(dosisLactantes.value);
    }
    if (fotoUrl.present) {
      map['foto_url'] = Variable<String>(fotoUrl.value);
    }
    if (fechaRevision.present) {
      map['fecha_revision'] = Variable<String>(fechaRevision.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<String>(actualizadoEn.value);
    }
    if (esFavorito.present) {
      map['es_favorito'] = Variable<bool>(esFavorito.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicamentosTableCompanion(')
          ..write('id: $id, ')
          ..write('codigoInterno: $codigoInterno, ')
          ..write('nombreComercial: $nombreComercial, ')
          ..write('nombreGenerico: $nombreGenerico, ')
          ..write('categoria: $categoria, ')
          ..write('laboratorios: $laboratorios, ')
          ..write('descripcion: $descripcion, ')
          ..write('principiosActivos: $principiosActivos, ')
          ..write('composicionCompleta: $composicionCompleta, ')
          ..write('concentraciones: $concentraciones, ')
          ..write('formasFarmaceuticas: $formasFarmaceuticas, ')
          ..write('presentacion: $presentacion, ')
          ..write('viasAdministracion: $viasAdministracion, ')
          ..write('indicacionesTexto: $indicacionesTexto, ')
          ..write('indicacionesTags: $indicacionesTags, ')
          ..write('contraindicaciones: $contraindicaciones, ')
          ..write('precaucionesAdvertencias: $precaucionesAdvertencias, ')
          ..write('efectosAdversos: $efectosAdversos, ')
          ..write('dosisAdultos: $dosisAdultos, ')
          ..write('dosisAdultosMayores: $dosisAdultosMayores, ')
          ..write('dosisPediatrica: $dosisPediatrica, ')
          ..write('dosisLactantes: $dosisLactantes, ')
          ..write('fotoUrl: $fotoUrl, ')
          ..write('fechaRevision: $fechaRevision, ')
          ..write('actualizadoEn: $actualizadoEn, ')
          ..write('esFavorito: $esFavorito, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicamentoGruposTableTable extends MedicamentoGruposTable
    with TableInfo<$MedicamentoGruposTableTable, MedicamentoGruposTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicamentoGruposTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _medicamentoIdMeta =
      const VerificationMeta('medicamentoId');
  @override
  late final GeneratedColumn<String> medicamentoId = GeneratedColumn<String>(
      'medicamento_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _grupoMeta = const VerificationMeta('grupo');
  @override
  late final GeneratedColumn<String> grupo = GeneratedColumn<String>(
      'grupo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('no_evaluado'));
  static const VerificationMeta _observacionMeta =
      const VerificationMeta('observacion');
  @override
  late final GeneratedColumn<String> observacion = GeneratedColumn<String>(
      'observacion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [medicamentoId, grupo, estado, observacion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicamento_grupos';
  @override
  VerificationContext validateIntegrity(
      Insertable<MedicamentoGruposTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('medicamento_id')) {
      context.handle(
          _medicamentoIdMeta,
          medicamentoId.isAcceptableOrUnknown(
              data['medicamento_id']!, _medicamentoIdMeta));
    } else if (isInserting) {
      context.missing(_medicamentoIdMeta);
    }
    if (data.containsKey('grupo')) {
      context.handle(
          _grupoMeta, grupo.isAcceptableOrUnknown(data['grupo']!, _grupoMeta));
    } else if (isInserting) {
      context.missing(_grupoMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('observacion')) {
      context.handle(
          _observacionMeta,
          observacion.isAcceptableOrUnknown(
              data['observacion']!, _observacionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {medicamentoId, grupo};
  @override
  MedicamentoGruposTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicamentoGruposTableData(
      medicamentoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicamento_id'])!,
      grupo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grupo'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      observacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacion']),
    );
  }

  @override
  $MedicamentoGruposTableTable createAlias(String alias) {
    return $MedicamentoGruposTableTable(attachedDatabase, alias);
  }
}

class MedicamentoGruposTableData extends DataClass
    implements Insertable<MedicamentoGruposTableData> {
  final String medicamentoId;
  final String grupo;
  final String estado;
  final String? observacion;
  const MedicamentoGruposTableData(
      {required this.medicamentoId,
      required this.grupo,
      required this.estado,
      this.observacion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['medicamento_id'] = Variable<String>(medicamentoId);
    map['grupo'] = Variable<String>(grupo);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || observacion != null) {
      map['observacion'] = Variable<String>(observacion);
    }
    return map;
  }

  MedicamentoGruposTableCompanion toCompanion(bool nullToAbsent) {
    return MedicamentoGruposTableCompanion(
      medicamentoId: Value(medicamentoId),
      grupo: Value(grupo),
      estado: Value(estado),
      observacion: observacion == null && nullToAbsent
          ? const Value.absent()
          : Value(observacion),
    );
  }

  factory MedicamentoGruposTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicamentoGruposTableData(
      medicamentoId: serializer.fromJson<String>(json['medicamentoId']),
      grupo: serializer.fromJson<String>(json['grupo']),
      estado: serializer.fromJson<String>(json['estado']),
      observacion: serializer.fromJson<String?>(json['observacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'medicamentoId': serializer.toJson<String>(medicamentoId),
      'grupo': serializer.toJson<String>(grupo),
      'estado': serializer.toJson<String>(estado),
      'observacion': serializer.toJson<String?>(observacion),
    };
  }

  MedicamentoGruposTableData copyWith(
          {String? medicamentoId,
          String? grupo,
          String? estado,
          Value<String?> observacion = const Value.absent()}) =>
      MedicamentoGruposTableData(
        medicamentoId: medicamentoId ?? this.medicamentoId,
        grupo: grupo ?? this.grupo,
        estado: estado ?? this.estado,
        observacion: observacion.present ? observacion.value : this.observacion,
      );
  MedicamentoGruposTableData copyWithCompanion(
      MedicamentoGruposTableCompanion data) {
    return MedicamentoGruposTableData(
      medicamentoId: data.medicamentoId.present
          ? data.medicamentoId.value
          : this.medicamentoId,
      grupo: data.grupo.present ? data.grupo.value : this.grupo,
      estado: data.estado.present ? data.estado.value : this.estado,
      observacion:
          data.observacion.present ? data.observacion.value : this.observacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicamentoGruposTableData(')
          ..write('medicamentoId: $medicamentoId, ')
          ..write('grupo: $grupo, ')
          ..write('estado: $estado, ')
          ..write('observacion: $observacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(medicamentoId, grupo, estado, observacion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicamentoGruposTableData &&
          other.medicamentoId == this.medicamentoId &&
          other.grupo == this.grupo &&
          other.estado == this.estado &&
          other.observacion == this.observacion);
}

class MedicamentoGruposTableCompanion
    extends UpdateCompanion<MedicamentoGruposTableData> {
  final Value<String> medicamentoId;
  final Value<String> grupo;
  final Value<String> estado;
  final Value<String?> observacion;
  final Value<int> rowid;
  const MedicamentoGruposTableCompanion({
    this.medicamentoId = const Value.absent(),
    this.grupo = const Value.absent(),
    this.estado = const Value.absent(),
    this.observacion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicamentoGruposTableCompanion.insert({
    required String medicamentoId,
    required String grupo,
    this.estado = const Value.absent(),
    this.observacion = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : medicamentoId = Value(medicamentoId),
        grupo = Value(grupo);
  static Insertable<MedicamentoGruposTableData> custom({
    Expression<String>? medicamentoId,
    Expression<String>? grupo,
    Expression<String>? estado,
    Expression<String>? observacion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (medicamentoId != null) 'medicamento_id': medicamentoId,
      if (grupo != null) 'grupo': grupo,
      if (estado != null) 'estado': estado,
      if (observacion != null) 'observacion': observacion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicamentoGruposTableCompanion copyWith(
      {Value<String>? medicamentoId,
      Value<String>? grupo,
      Value<String>? estado,
      Value<String?>? observacion,
      Value<int>? rowid}) {
    return MedicamentoGruposTableCompanion(
      medicamentoId: medicamentoId ?? this.medicamentoId,
      grupo: grupo ?? this.grupo,
      estado: estado ?? this.estado,
      observacion: observacion ?? this.observacion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (medicamentoId.present) {
      map['medicamento_id'] = Variable<String>(medicamentoId.value);
    }
    if (grupo.present) {
      map['grupo'] = Variable<String>(grupo.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (observacion.present) {
      map['observacion'] = Variable<String>(observacion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicamentoGruposTableCompanion(')
          ..write('medicamentoId: $medicamentoId, ')
          ..write('grupo: $grupo, ')
          ..write('estado: $estado, ')
          ..write('observacion: $observacion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HistorialTableTable extends HistorialTable
    with TableInfo<$HistorialTableTable, HistorialTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistorialTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _medicamentoIdMeta =
      const VerificationMeta('medicamentoId');
  @override
  late final GeneratedColumn<String> medicamentoId = GeneratedColumn<String>(
      'medicamento_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreSnapshotMeta =
      const VerificationMeta('nombreSnapshot');
  @override
  late final GeneratedColumn<String> nombreSnapshot = GeneratedColumn<String>(
      'nombre_snapshot', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('busqueda'));
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, medicamentoId, nombreSnapshot, tipo, fecha];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historial';
  @override
  VerificationContext validateIntegrity(Insertable<HistorialTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('medicamento_id')) {
      context.handle(
          _medicamentoIdMeta,
          medicamentoId.isAcceptableOrUnknown(
              data['medicamento_id']!, _medicamentoIdMeta));
    } else if (isInserting) {
      context.missing(_medicamentoIdMeta);
    }
    if (data.containsKey('nombre_snapshot')) {
      context.handle(
          _nombreSnapshotMeta,
          nombreSnapshot.isAcceptableOrUnknown(
              data['nombre_snapshot']!, _nombreSnapshotMeta));
    } else if (isInserting) {
      context.missing(_nombreSnapshotMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
          _fechaMeta, fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta));
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistorialTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistorialTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      medicamentoId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicamento_id'])!,
      nombreSnapshot: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nombre_snapshot'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      fecha: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha'])!,
    );
  }

  @override
  $HistorialTableTable createAlias(String alias) {
    return $HistorialTableTable(attachedDatabase, alias);
  }
}

class HistorialTableData extends DataClass
    implements Insertable<HistorialTableData> {
  final String id;
  final String medicamentoId;
  final String nombreSnapshot;
  final String tipo;
  final DateTime fecha;
  const HistorialTableData(
      {required this.id,
      required this.medicamentoId,
      required this.nombreSnapshot,
      required this.tipo,
      required this.fecha});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['medicamento_id'] = Variable<String>(medicamentoId);
    map['nombre_snapshot'] = Variable<String>(nombreSnapshot);
    map['tipo'] = Variable<String>(tipo);
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  HistorialTableCompanion toCompanion(bool nullToAbsent) {
    return HistorialTableCompanion(
      id: Value(id),
      medicamentoId: Value(medicamentoId),
      nombreSnapshot: Value(nombreSnapshot),
      tipo: Value(tipo),
      fecha: Value(fecha),
    );
  }

  factory HistorialTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistorialTableData(
      id: serializer.fromJson<String>(json['id']),
      medicamentoId: serializer.fromJson<String>(json['medicamentoId']),
      nombreSnapshot: serializer.fromJson<String>(json['nombreSnapshot']),
      tipo: serializer.fromJson<String>(json['tipo']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'medicamentoId': serializer.toJson<String>(medicamentoId),
      'nombreSnapshot': serializer.toJson<String>(nombreSnapshot),
      'tipo': serializer.toJson<String>(tipo),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  HistorialTableData copyWith(
          {String? id,
          String? medicamentoId,
          String? nombreSnapshot,
          String? tipo,
          DateTime? fecha}) =>
      HistorialTableData(
        id: id ?? this.id,
        medicamentoId: medicamentoId ?? this.medicamentoId,
        nombreSnapshot: nombreSnapshot ?? this.nombreSnapshot,
        tipo: tipo ?? this.tipo,
        fecha: fecha ?? this.fecha,
      );
  HistorialTableData copyWithCompanion(HistorialTableCompanion data) {
    return HistorialTableData(
      id: data.id.present ? data.id.value : this.id,
      medicamentoId: data.medicamentoId.present
          ? data.medicamentoId.value
          : this.medicamentoId,
      nombreSnapshot: data.nombreSnapshot.present
          ? data.nombreSnapshot.value
          : this.nombreSnapshot,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistorialTableData(')
          ..write('id: $id, ')
          ..write('medicamentoId: $medicamentoId, ')
          ..write('nombreSnapshot: $nombreSnapshot, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, medicamentoId, nombreSnapshot, tipo, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorialTableData &&
          other.id == this.id &&
          other.medicamentoId == this.medicamentoId &&
          other.nombreSnapshot == this.nombreSnapshot &&
          other.tipo == this.tipo &&
          other.fecha == this.fecha);
}

class HistorialTableCompanion extends UpdateCompanion<HistorialTableData> {
  final Value<String> id;
  final Value<String> medicamentoId;
  final Value<String> nombreSnapshot;
  final Value<String> tipo;
  final Value<DateTime> fecha;
  final Value<int> rowid;
  const HistorialTableCompanion({
    this.id = const Value.absent(),
    this.medicamentoId = const Value.absent(),
    this.nombreSnapshot = const Value.absent(),
    this.tipo = const Value.absent(),
    this.fecha = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HistorialTableCompanion.insert({
    required String id,
    required String medicamentoId,
    required String nombreSnapshot,
    this.tipo = const Value.absent(),
    required DateTime fecha,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        medicamentoId = Value(medicamentoId),
        nombreSnapshot = Value(nombreSnapshot),
        fecha = Value(fecha);
  static Insertable<HistorialTableData> custom({
    Expression<String>? id,
    Expression<String>? medicamentoId,
    Expression<String>? nombreSnapshot,
    Expression<String>? tipo,
    Expression<DateTime>? fecha,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicamentoId != null) 'medicamento_id': medicamentoId,
      if (nombreSnapshot != null) 'nombre_snapshot': nombreSnapshot,
      if (tipo != null) 'tipo': tipo,
      if (fecha != null) 'fecha': fecha,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HistorialTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? medicamentoId,
      Value<String>? nombreSnapshot,
      Value<String>? tipo,
      Value<DateTime>? fecha,
      Value<int>? rowid}) {
    return HistorialTableCompanion(
      id: id ?? this.id,
      medicamentoId: medicamentoId ?? this.medicamentoId,
      nombreSnapshot: nombreSnapshot ?? this.nombreSnapshot,
      tipo: tipo ?? this.tipo,
      fecha: fecha ?? this.fecha,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (medicamentoId.present) {
      map['medicamento_id'] = Variable<String>(medicamentoId.value);
    }
    if (nombreSnapshot.present) {
      map['nombre_snapshot'] = Variable<String>(nombreSnapshot.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistorialTableCompanion(')
          ..write('id: $id, ')
          ..write('medicamentoId: $medicamentoId, ')
          ..write('nombreSnapshot: $nombreSnapshot, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTableTable extends SyncMetaTable
    with TableInfo<$SyncMetaTableTable, SyncMetaTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
      'clave', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
      'valor', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [clave, valor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(Insertable<SyncMetaTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clave')) {
      context.handle(
          _claveMeta, clave.isAcceptableOrUnknown(data['clave']!, _claveMeta));
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
          _valorMeta, valor.isAcceptableOrUnknown(data['valor']!, _valorMeta));
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clave};
  @override
  SyncMetaTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaTableData(
      clave: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}clave'])!,
      valor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}valor'])!,
    );
  }

  @override
  $SyncMetaTableTable createAlias(String alias) {
    return $SyncMetaTableTable(attachedDatabase, alias);
  }
}

class SyncMetaTableData extends DataClass
    implements Insertable<SyncMetaTableData> {
  final String clave;
  final String valor;
  const SyncMetaTableData({required this.clave, required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clave'] = Variable<String>(clave);
    map['valor'] = Variable<String>(valor);
    return map;
  }

  SyncMetaTableCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaTableCompanion(
      clave: Value(clave),
      valor: Value(valor),
    );
  }

  factory SyncMetaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaTableData(
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String>(valor),
    };
  }

  SyncMetaTableData copyWith({String? clave, String? valor}) =>
      SyncMetaTableData(
        clave: clave ?? this.clave,
        valor: valor ?? this.valor,
      );
  SyncMetaTableData copyWithCompanion(SyncMetaTableCompanion data) {
    return SyncMetaTableData(
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaTableData(')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clave, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaTableData &&
          other.clave == this.clave &&
          other.valor == this.valor);
}

class SyncMetaTableCompanion extends UpdateCompanion<SyncMetaTableData> {
  final Value<String> clave;
  final Value<String> valor;
  final Value<int> rowid;
  const SyncMetaTableCompanion({
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaTableCompanion.insert({
    required String clave,
    required String valor,
    this.rowid = const Value.absent(),
  })  : clave = Value(clave),
        valor = Value(valor);
  static Insertable<SyncMetaTableData> custom({
    Expression<String>? clave,
    Expression<String>? valor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaTableCompanion copyWith(
      {Value<String>? clave, Value<String>? valor, Value<int>? rowid}) {
    return SyncMetaTableCompanion(
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaTableCompanion(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MedicamentosTableTable medicamentosTable =
      $MedicamentosTableTable(this);
  late final $MedicamentoGruposTableTable medicamentoGruposTable =
      $MedicamentoGruposTableTable(this);
  late final $HistorialTableTable historialTable = $HistorialTableTable(this);
  late final $SyncMetaTableTable syncMetaTable = $SyncMetaTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        medicamentosTable,
        medicamentoGruposTable,
        historialTable,
        syncMetaTable
      ];
}

typedef $$MedicamentosTableTableCreateCompanionBuilder
    = MedicamentosTableCompanion Function({
  required String id,
  required String codigoInterno,
  required String nombreComercial,
  Value<String?> nombreGenerico,
  Value<String?> categoria,
  Value<String> laboratorios,
  Value<String?> descripcion,
  Value<String> principiosActivos,
  Value<String?> composicionCompleta,
  Value<String> concentraciones,
  Value<String> formasFarmaceuticas,
  Value<String?> presentacion,
  Value<String> viasAdministracion,
  Value<String?> indicacionesTexto,
  Value<String> indicacionesTags,
  Value<String?> contraindicaciones,
  Value<String?> precaucionesAdvertencias,
  Value<String?> efectosAdversos,
  Value<String?> dosisAdultos,
  Value<String?> dosisAdultosMayores,
  Value<String?> dosisPediatrica,
  Value<String?> dosisLactantes,
  Value<String?> fotoUrl,
  Value<String?> fechaRevision,
  Value<String?> actualizadoEn,
  Value<bool> esFavorito,
  Value<int> rowid,
});
typedef $$MedicamentosTableTableUpdateCompanionBuilder
    = MedicamentosTableCompanion Function({
  Value<String> id,
  Value<String> codigoInterno,
  Value<String> nombreComercial,
  Value<String?> nombreGenerico,
  Value<String?> categoria,
  Value<String> laboratorios,
  Value<String?> descripcion,
  Value<String> principiosActivos,
  Value<String?> composicionCompleta,
  Value<String> concentraciones,
  Value<String> formasFarmaceuticas,
  Value<String?> presentacion,
  Value<String> viasAdministracion,
  Value<String?> indicacionesTexto,
  Value<String> indicacionesTags,
  Value<String?> contraindicaciones,
  Value<String?> precaucionesAdvertencias,
  Value<String?> efectosAdversos,
  Value<String?> dosisAdultos,
  Value<String?> dosisAdultosMayores,
  Value<String?> dosisPediatrica,
  Value<String?> dosisLactantes,
  Value<String?> fotoUrl,
  Value<String?> fechaRevision,
  Value<String?> actualizadoEn,
  Value<bool> esFavorito,
  Value<int> rowid,
});

class $$MedicamentosTableTableFilterComposer
    extends Composer<_$AppDatabase, $MedicamentosTableTable> {
  $$MedicamentosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigoInterno => $composableBuilder(
      column: $table.codigoInterno, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombreComercial => $composableBuilder(
      column: $table.nombreComercial,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombreGenerico => $composableBuilder(
      column: $table.nombreGenerico,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get laboratorios => $composableBuilder(
      column: $table.laboratorios, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get principiosActivos => $composableBuilder(
      column: $table.principiosActivos,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get composicionCompleta => $composableBuilder(
      column: $table.composicionCompleta,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get concentraciones => $composableBuilder(
      column: $table.concentraciones,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formasFarmaceuticas => $composableBuilder(
      column: $table.formasFarmaceuticas,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get presentacion => $composableBuilder(
      column: $table.presentacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get viasAdministracion => $composableBuilder(
      column: $table.viasAdministracion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get indicacionesTexto => $composableBuilder(
      column: $table.indicacionesTexto,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get indicacionesTags => $composableBuilder(
      column: $table.indicacionesTags,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contraindicaciones => $composableBuilder(
      column: $table.contraindicaciones,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get precaucionesAdvertencias => $composableBuilder(
      column: $table.precaucionesAdvertencias,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get efectosAdversos => $composableBuilder(
      column: $table.efectosAdversos,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosisAdultos => $composableBuilder(
      column: $table.dosisAdultos, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosisAdultosMayores => $composableBuilder(
      column: $table.dosisAdultosMayores,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosisPediatrica => $composableBuilder(
      column: $table.dosisPediatrica,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosisLactantes => $composableBuilder(
      column: $table.dosisLactantes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fotoUrl => $composableBuilder(
      column: $table.fotoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fechaRevision => $composableBuilder(
      column: $table.fechaRevision, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get actualizadoEn => $composableBuilder(
      column: $table.actualizadoEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get esFavorito => $composableBuilder(
      column: $table.esFavorito, builder: (column) => ColumnFilters(column));
}

class $$MedicamentosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicamentosTableTable> {
  $$MedicamentosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigoInterno => $composableBuilder(
      column: $table.codigoInterno,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombreComercial => $composableBuilder(
      column: $table.nombreComercial,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombreGenerico => $composableBuilder(
      column: $table.nombreGenerico,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoria => $composableBuilder(
      column: $table.categoria, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get laboratorios => $composableBuilder(
      column: $table.laboratorios,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get principiosActivos => $composableBuilder(
      column: $table.principiosActivos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get composicionCompleta => $composableBuilder(
      column: $table.composicionCompleta,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get concentraciones => $composableBuilder(
      column: $table.concentraciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formasFarmaceuticas => $composableBuilder(
      column: $table.formasFarmaceuticas,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get presentacion => $composableBuilder(
      column: $table.presentacion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get viasAdministracion => $composableBuilder(
      column: $table.viasAdministracion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get indicacionesTexto => $composableBuilder(
      column: $table.indicacionesTexto,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get indicacionesTags => $composableBuilder(
      column: $table.indicacionesTags,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contraindicaciones => $composableBuilder(
      column: $table.contraindicaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get precaucionesAdvertencias => $composableBuilder(
      column: $table.precaucionesAdvertencias,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get efectosAdversos => $composableBuilder(
      column: $table.efectosAdversos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosisAdultos => $composableBuilder(
      column: $table.dosisAdultos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosisAdultosMayores => $composableBuilder(
      column: $table.dosisAdultosMayores,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosisPediatrica => $composableBuilder(
      column: $table.dosisPediatrica,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosisLactantes => $composableBuilder(
      column: $table.dosisLactantes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotoUrl => $composableBuilder(
      column: $table.fotoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fechaRevision => $composableBuilder(
      column: $table.fechaRevision,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get actualizadoEn => $composableBuilder(
      column: $table.actualizadoEn,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get esFavorito => $composableBuilder(
      column: $table.esFavorito, builder: (column) => ColumnOrderings(column));
}

class $$MedicamentosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicamentosTableTable> {
  $$MedicamentosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get codigoInterno => $composableBuilder(
      column: $table.codigoInterno, builder: (column) => column);

  GeneratedColumn<String> get nombreComercial => $composableBuilder(
      column: $table.nombreComercial, builder: (column) => column);

  GeneratedColumn<String> get nombreGenerico => $composableBuilder(
      column: $table.nombreGenerico, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get laboratorios => $composableBuilder(
      column: $table.laboratorios, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<String> get principiosActivos => $composableBuilder(
      column: $table.principiosActivos, builder: (column) => column);

  GeneratedColumn<String> get composicionCompleta => $composableBuilder(
      column: $table.composicionCompleta, builder: (column) => column);

  GeneratedColumn<String> get concentraciones => $composableBuilder(
      column: $table.concentraciones, builder: (column) => column);

  GeneratedColumn<String> get formasFarmaceuticas => $composableBuilder(
      column: $table.formasFarmaceuticas, builder: (column) => column);

  GeneratedColumn<String> get presentacion => $composableBuilder(
      column: $table.presentacion, builder: (column) => column);

  GeneratedColumn<String> get viasAdministracion => $composableBuilder(
      column: $table.viasAdministracion, builder: (column) => column);

  GeneratedColumn<String> get indicacionesTexto => $composableBuilder(
      column: $table.indicacionesTexto, builder: (column) => column);

  GeneratedColumn<String> get indicacionesTags => $composableBuilder(
      column: $table.indicacionesTags, builder: (column) => column);

  GeneratedColumn<String> get contraindicaciones => $composableBuilder(
      column: $table.contraindicaciones, builder: (column) => column);

  GeneratedColumn<String> get precaucionesAdvertencias => $composableBuilder(
      column: $table.precaucionesAdvertencias, builder: (column) => column);

  GeneratedColumn<String> get efectosAdversos => $composableBuilder(
      column: $table.efectosAdversos, builder: (column) => column);

  GeneratedColumn<String> get dosisAdultos => $composableBuilder(
      column: $table.dosisAdultos, builder: (column) => column);

  GeneratedColumn<String> get dosisAdultosMayores => $composableBuilder(
      column: $table.dosisAdultosMayores, builder: (column) => column);

  GeneratedColumn<String> get dosisPediatrica => $composableBuilder(
      column: $table.dosisPediatrica, builder: (column) => column);

  GeneratedColumn<String> get dosisLactantes => $composableBuilder(
      column: $table.dosisLactantes, builder: (column) => column);

  GeneratedColumn<String> get fotoUrl =>
      $composableBuilder(column: $table.fotoUrl, builder: (column) => column);

  GeneratedColumn<String> get fechaRevision => $composableBuilder(
      column: $table.fechaRevision, builder: (column) => column);

  GeneratedColumn<String> get actualizadoEn => $composableBuilder(
      column: $table.actualizadoEn, builder: (column) => column);

  GeneratedColumn<bool> get esFavorito => $composableBuilder(
      column: $table.esFavorito, builder: (column) => column);
}

class $$MedicamentosTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicamentosTableTable,
    MedicamentosTableData,
    $$MedicamentosTableTableFilterComposer,
    $$MedicamentosTableTableOrderingComposer,
    $$MedicamentosTableTableAnnotationComposer,
    $$MedicamentosTableTableCreateCompanionBuilder,
    $$MedicamentosTableTableUpdateCompanionBuilder,
    (
      MedicamentosTableData,
      BaseReferences<_$AppDatabase, $MedicamentosTableTable,
          MedicamentosTableData>
    ),
    MedicamentosTableData,
    PrefetchHooks Function()> {
  $$MedicamentosTableTableTableManager(
      _$AppDatabase db, $MedicamentosTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicamentosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicamentosTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicamentosTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> codigoInterno = const Value.absent(),
            Value<String> nombreComercial = const Value.absent(),
            Value<String?> nombreGenerico = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<String> laboratorios = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<String> principiosActivos = const Value.absent(),
            Value<String?> composicionCompleta = const Value.absent(),
            Value<String> concentraciones = const Value.absent(),
            Value<String> formasFarmaceuticas = const Value.absent(),
            Value<String?> presentacion = const Value.absent(),
            Value<String> viasAdministracion = const Value.absent(),
            Value<String?> indicacionesTexto = const Value.absent(),
            Value<String> indicacionesTags = const Value.absent(),
            Value<String?> contraindicaciones = const Value.absent(),
            Value<String?> precaucionesAdvertencias = const Value.absent(),
            Value<String?> efectosAdversos = const Value.absent(),
            Value<String?> dosisAdultos = const Value.absent(),
            Value<String?> dosisAdultosMayores = const Value.absent(),
            Value<String?> dosisPediatrica = const Value.absent(),
            Value<String?> dosisLactantes = const Value.absent(),
            Value<String?> fotoUrl = const Value.absent(),
            Value<String?> fechaRevision = const Value.absent(),
            Value<String?> actualizadoEn = const Value.absent(),
            Value<bool> esFavorito = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicamentosTableCompanion(
            id: id,
            codigoInterno: codigoInterno,
            nombreComercial: nombreComercial,
            nombreGenerico: nombreGenerico,
            categoria: categoria,
            laboratorios: laboratorios,
            descripcion: descripcion,
            principiosActivos: principiosActivos,
            composicionCompleta: composicionCompleta,
            concentraciones: concentraciones,
            formasFarmaceuticas: formasFarmaceuticas,
            presentacion: presentacion,
            viasAdministracion: viasAdministracion,
            indicacionesTexto: indicacionesTexto,
            indicacionesTags: indicacionesTags,
            contraindicaciones: contraindicaciones,
            precaucionesAdvertencias: precaucionesAdvertencias,
            efectosAdversos: efectosAdversos,
            dosisAdultos: dosisAdultos,
            dosisAdultosMayores: dosisAdultosMayores,
            dosisPediatrica: dosisPediatrica,
            dosisLactantes: dosisLactantes,
            fotoUrl: fotoUrl,
            fechaRevision: fechaRevision,
            actualizadoEn: actualizadoEn,
            esFavorito: esFavorito,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String codigoInterno,
            required String nombreComercial,
            Value<String?> nombreGenerico = const Value.absent(),
            Value<String?> categoria = const Value.absent(),
            Value<String> laboratorios = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<String> principiosActivos = const Value.absent(),
            Value<String?> composicionCompleta = const Value.absent(),
            Value<String> concentraciones = const Value.absent(),
            Value<String> formasFarmaceuticas = const Value.absent(),
            Value<String?> presentacion = const Value.absent(),
            Value<String> viasAdministracion = const Value.absent(),
            Value<String?> indicacionesTexto = const Value.absent(),
            Value<String> indicacionesTags = const Value.absent(),
            Value<String?> contraindicaciones = const Value.absent(),
            Value<String?> precaucionesAdvertencias = const Value.absent(),
            Value<String?> efectosAdversos = const Value.absent(),
            Value<String?> dosisAdultos = const Value.absent(),
            Value<String?> dosisAdultosMayores = const Value.absent(),
            Value<String?> dosisPediatrica = const Value.absent(),
            Value<String?> dosisLactantes = const Value.absent(),
            Value<String?> fotoUrl = const Value.absent(),
            Value<String?> fechaRevision = const Value.absent(),
            Value<String?> actualizadoEn = const Value.absent(),
            Value<bool> esFavorito = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicamentosTableCompanion.insert(
            id: id,
            codigoInterno: codigoInterno,
            nombreComercial: nombreComercial,
            nombreGenerico: nombreGenerico,
            categoria: categoria,
            laboratorios: laboratorios,
            descripcion: descripcion,
            principiosActivos: principiosActivos,
            composicionCompleta: composicionCompleta,
            concentraciones: concentraciones,
            formasFarmaceuticas: formasFarmaceuticas,
            presentacion: presentacion,
            viasAdministracion: viasAdministracion,
            indicacionesTexto: indicacionesTexto,
            indicacionesTags: indicacionesTags,
            contraindicaciones: contraindicaciones,
            precaucionesAdvertencias: precaucionesAdvertencias,
            efectosAdversos: efectosAdversos,
            dosisAdultos: dosisAdultos,
            dosisAdultosMayores: dosisAdultosMayores,
            dosisPediatrica: dosisPediatrica,
            dosisLactantes: dosisLactantes,
            fotoUrl: fotoUrl,
            fechaRevision: fechaRevision,
            actualizadoEn: actualizadoEn,
            esFavorito: esFavorito,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicamentosTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicamentosTableTable,
    MedicamentosTableData,
    $$MedicamentosTableTableFilterComposer,
    $$MedicamentosTableTableOrderingComposer,
    $$MedicamentosTableTableAnnotationComposer,
    $$MedicamentosTableTableCreateCompanionBuilder,
    $$MedicamentosTableTableUpdateCompanionBuilder,
    (
      MedicamentosTableData,
      BaseReferences<_$AppDatabase, $MedicamentosTableTable,
          MedicamentosTableData>
    ),
    MedicamentosTableData,
    PrefetchHooks Function()>;
typedef $$MedicamentoGruposTableTableCreateCompanionBuilder
    = MedicamentoGruposTableCompanion Function({
  required String medicamentoId,
  required String grupo,
  Value<String> estado,
  Value<String?> observacion,
  Value<int> rowid,
});
typedef $$MedicamentoGruposTableTableUpdateCompanionBuilder
    = MedicamentoGruposTableCompanion Function({
  Value<String> medicamentoId,
  Value<String> grupo,
  Value<String> estado,
  Value<String?> observacion,
  Value<int> rowid,
});

class $$MedicamentoGruposTableTableFilterComposer
    extends Composer<_$AppDatabase, $MedicamentoGruposTableTable> {
  $$MedicamentoGruposTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get medicamentoId => $composableBuilder(
      column: $table.medicamentoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grupo => $composableBuilder(
      column: $table.grupo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacion => $composableBuilder(
      column: $table.observacion, builder: (column) => ColumnFilters(column));
}

class $$MedicamentoGruposTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicamentoGruposTableTable> {
  $$MedicamentoGruposTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get medicamentoId => $composableBuilder(
      column: $table.medicamentoId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grupo => $composableBuilder(
      column: $table.grupo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacion => $composableBuilder(
      column: $table.observacion, builder: (column) => ColumnOrderings(column));
}

class $$MedicamentoGruposTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicamentoGruposTableTable> {
  $$MedicamentoGruposTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get medicamentoId => $composableBuilder(
      column: $table.medicamentoId, builder: (column) => column);

  GeneratedColumn<String> get grupo =>
      $composableBuilder(column: $table.grupo, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<String> get observacion => $composableBuilder(
      column: $table.observacion, builder: (column) => column);
}

class $$MedicamentoGruposTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicamentoGruposTableTable,
    MedicamentoGruposTableData,
    $$MedicamentoGruposTableTableFilterComposer,
    $$MedicamentoGruposTableTableOrderingComposer,
    $$MedicamentoGruposTableTableAnnotationComposer,
    $$MedicamentoGruposTableTableCreateCompanionBuilder,
    $$MedicamentoGruposTableTableUpdateCompanionBuilder,
    (
      MedicamentoGruposTableData,
      BaseReferences<_$AppDatabase, $MedicamentoGruposTableTable,
          MedicamentoGruposTableData>
    ),
    MedicamentoGruposTableData,
    PrefetchHooks Function()> {
  $$MedicamentoGruposTableTableTableManager(
      _$AppDatabase db, $MedicamentoGruposTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicamentoGruposTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicamentoGruposTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicamentoGruposTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> medicamentoId = const Value.absent(),
            Value<String> grupo = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<String?> observacion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicamentoGruposTableCompanion(
            medicamentoId: medicamentoId,
            grupo: grupo,
            estado: estado,
            observacion: observacion,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String medicamentoId,
            required String grupo,
            Value<String> estado = const Value.absent(),
            Value<String?> observacion = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicamentoGruposTableCompanion.insert(
            medicamentoId: medicamentoId,
            grupo: grupo,
            estado: estado,
            observacion: observacion,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MedicamentoGruposTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $MedicamentoGruposTableTable,
        MedicamentoGruposTableData,
        $$MedicamentoGruposTableTableFilterComposer,
        $$MedicamentoGruposTableTableOrderingComposer,
        $$MedicamentoGruposTableTableAnnotationComposer,
        $$MedicamentoGruposTableTableCreateCompanionBuilder,
        $$MedicamentoGruposTableTableUpdateCompanionBuilder,
        (
          MedicamentoGruposTableData,
          BaseReferences<_$AppDatabase, $MedicamentoGruposTableTable,
              MedicamentoGruposTableData>
        ),
        MedicamentoGruposTableData,
        PrefetchHooks Function()>;
typedef $$HistorialTableTableCreateCompanionBuilder = HistorialTableCompanion
    Function({
  required String id,
  required String medicamentoId,
  required String nombreSnapshot,
  Value<String> tipo,
  required DateTime fecha,
  Value<int> rowid,
});
typedef $$HistorialTableTableUpdateCompanionBuilder = HistorialTableCompanion
    Function({
  Value<String> id,
  Value<String> medicamentoId,
  Value<String> nombreSnapshot,
  Value<String> tipo,
  Value<DateTime> fecha,
  Value<int> rowid,
});

class $$HistorialTableTableFilterComposer
    extends Composer<_$AppDatabase, $HistorialTableTable> {
  $$HistorialTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicamentoId => $composableBuilder(
      column: $table.medicamentoId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombreSnapshot => $composableBuilder(
      column: $table.nombreSnapshot,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnFilters(column));
}

class $$HistorialTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HistorialTableTable> {
  $$HistorialTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicamentoId => $composableBuilder(
      column: $table.medicamentoId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombreSnapshot => $composableBuilder(
      column: $table.nombreSnapshot,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
      column: $table.fecha, builder: (column) => ColumnOrderings(column));
}

class $$HistorialTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistorialTableTable> {
  $$HistorialTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicamentoId => $composableBuilder(
      column: $table.medicamentoId, builder: (column) => column);

  GeneratedColumn<String> get nombreSnapshot => $composableBuilder(
      column: $table.nombreSnapshot, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$HistorialTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HistorialTableTable,
    HistorialTableData,
    $$HistorialTableTableFilterComposer,
    $$HistorialTableTableOrderingComposer,
    $$HistorialTableTableAnnotationComposer,
    $$HistorialTableTableCreateCompanionBuilder,
    $$HistorialTableTableUpdateCompanionBuilder,
    (
      HistorialTableData,
      BaseReferences<_$AppDatabase, $HistorialTableTable, HistorialTableData>
    ),
    HistorialTableData,
    PrefetchHooks Function()> {
  $$HistorialTableTableTableManager(
      _$AppDatabase db, $HistorialTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistorialTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistorialTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistorialTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> medicamentoId = const Value.absent(),
            Value<String> nombreSnapshot = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HistorialTableCompanion(
            id: id,
            medicamentoId: medicamentoId,
            nombreSnapshot: nombreSnapshot,
            tipo: tipo,
            fecha: fecha,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String medicamentoId,
            required String nombreSnapshot,
            Value<String> tipo = const Value.absent(),
            required DateTime fecha,
            Value<int> rowid = const Value.absent(),
          }) =>
              HistorialTableCompanion.insert(
            id: id,
            medicamentoId: medicamentoId,
            nombreSnapshot: nombreSnapshot,
            tipo: tipo,
            fecha: fecha,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HistorialTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HistorialTableTable,
    HistorialTableData,
    $$HistorialTableTableFilterComposer,
    $$HistorialTableTableOrderingComposer,
    $$HistorialTableTableAnnotationComposer,
    $$HistorialTableTableCreateCompanionBuilder,
    $$HistorialTableTableUpdateCompanionBuilder,
    (
      HistorialTableData,
      BaseReferences<_$AppDatabase, $HistorialTableTable, HistorialTableData>
    ),
    HistorialTableData,
    PrefetchHooks Function()>;
typedef $$SyncMetaTableTableCreateCompanionBuilder = SyncMetaTableCompanion
    Function({
  required String clave,
  required String valor,
  Value<int> rowid,
});
typedef $$SyncMetaTableTableUpdateCompanionBuilder = SyncMetaTableCompanion
    Function({
  Value<String> clave,
  Value<String> valor,
  Value<int> rowid,
});

class $$SyncMetaTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTableTable> {
  $$SyncMetaTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clave => $composableBuilder(
      column: $table.clave, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnFilters(column));
}

class $$SyncMetaTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTableTable> {
  $$SyncMetaTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clave => $composableBuilder(
      column: $table.clave, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get valor => $composableBuilder(
      column: $table.valor, builder: (column) => ColumnOrderings(column));
}

class $$SyncMetaTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTableTable> {
  $$SyncMetaTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);
}

class $$SyncMetaTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncMetaTableTable,
    SyncMetaTableData,
    $$SyncMetaTableTableFilterComposer,
    $$SyncMetaTableTableOrderingComposer,
    $$SyncMetaTableTableAnnotationComposer,
    $$SyncMetaTableTableCreateCompanionBuilder,
    $$SyncMetaTableTableUpdateCompanionBuilder,
    (
      SyncMetaTableData,
      BaseReferences<_$AppDatabase, $SyncMetaTableTable, SyncMetaTableData>
    ),
    SyncMetaTableData,
    PrefetchHooks Function()> {
  $$SyncMetaTableTableTableManager(_$AppDatabase db, $SyncMetaTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clave = const Value.absent(),
            Value<String> valor = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetaTableCompanion(
            clave: clave,
            valor: valor,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clave,
            required String valor,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncMetaTableCompanion.insert(
            clave: clave,
            valor: valor,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncMetaTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncMetaTableTable,
    SyncMetaTableData,
    $$SyncMetaTableTableFilterComposer,
    $$SyncMetaTableTableOrderingComposer,
    $$SyncMetaTableTableAnnotationComposer,
    $$SyncMetaTableTableCreateCompanionBuilder,
    $$SyncMetaTableTableUpdateCompanionBuilder,
    (
      SyncMetaTableData,
      BaseReferences<_$AppDatabase, $SyncMetaTableTable, SyncMetaTableData>
    ),
    SyncMetaTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MedicamentosTableTableTableManager get medicamentosTable =>
      $$MedicamentosTableTableTableManager(_db, _db.medicamentosTable);
  $$MedicamentoGruposTableTableTableManager get medicamentoGruposTable =>
      $$MedicamentoGruposTableTableTableManager(
          _db, _db.medicamentoGruposTable);
  $$HistorialTableTableTableManager get historialTable =>
      $$HistorialTableTableTableManager(_db, _db.historialTable);
  $$SyncMetaTableTableTableManager get syncMetaTable =>
      $$SyncMetaTableTableTableManager(_db, _db.syncMetaTable);
}
