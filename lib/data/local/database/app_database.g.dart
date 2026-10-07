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
  static const VerificationMeta _codigoBarrasMeta =
      const VerificationMeta('codigoBarras');
  @override
  late final GeneratedColumn<String> codigoBarras = GeneratedColumn<String>(
      'codigo_barras', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fotoUrlMeta =
      const VerificationMeta('fotoUrl');
  @override
  late final GeneratedColumn<String> fotoUrl = GeneratedColumn<String>(
      'foto_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosisAdultoMeta =
      const VerificationMeta('dosisAdulto');
  @override
  late final GeneratedColumn<String> dosisAdulto = GeneratedColumn<String>(
      'dosis_adulto', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosisMayorMeta =
      const VerificationMeta('dosisMayor');
  @override
  late final GeneratedColumn<String> dosisMayor = GeneratedColumn<String>(
      'dosis_mayor', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dosisNinoMeta =
      const VerificationMeta('dosisNino');
  @override
  late final GeneratedColumn<String> dosisNino = GeneratedColumn<String>(
      'dosis_nino', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _alergiasMeta =
      const VerificationMeta('alergias');
  @override
  late final GeneratedColumn<String> alergias = GeneratedColumn<String>(
      'alergias', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  static const VerificationMeta _contraindicacionesMeta =
      const VerificationMeta('contraindicaciones');
  @override
  late final GeneratedColumn<String> contraindicaciones =
      GeneratedColumn<String>('contraindicaciones', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _enfermedadesIncompatiblesMeta =
      const VerificationMeta('enfermedadesIncompatibles');
  @override
  late final GeneratedColumn<String> enfermedadesIncompatibles =
      GeneratedColumn<String>('enfermedades_incompatibles', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _actualizadoEnMeta =
      const VerificationMeta('actualizadoEn');
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>('actualizado_en', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _eliminadoMeta =
      const VerificationMeta('eliminado');
  @override
  late final GeneratedColumn<bool> eliminado = GeneratedColumn<bool>(
      'eliminado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("eliminado" IN (0, 1))'),
      defaultValue: const Constant(false));
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
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        codigoBarras,
        nombre,
        descripcion,
        fotoUrl,
        dosisAdulto,
        dosisMayor,
        dosisNino,
        alergias,
        contraindicaciones,
        enfermedadesIncompatibles,
        actualizadoEn,
        eliminado,
        esFavorito,
        sincronizado
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicamentos_table';
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
    if (data.containsKey('codigo_barras')) {
      context.handle(
          _codigoBarrasMeta,
          codigoBarras.isAcceptableOrUnknown(
              data['codigo_barras']!, _codigoBarrasMeta));
    } else if (isInserting) {
      context.missing(_codigoBarrasMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    }
    if (data.containsKey('foto_url')) {
      context.handle(_fotoUrlMeta,
          fotoUrl.isAcceptableOrUnknown(data['foto_url']!, _fotoUrlMeta));
    }
    if (data.containsKey('dosis_adulto')) {
      context.handle(
          _dosisAdultoMeta,
          dosisAdulto.isAcceptableOrUnknown(
              data['dosis_adulto']!, _dosisAdultoMeta));
    }
    if (data.containsKey('dosis_mayor')) {
      context.handle(
          _dosisMayorMeta,
          dosisMayor.isAcceptableOrUnknown(
              data['dosis_mayor']!, _dosisMayorMeta));
    }
    if (data.containsKey('dosis_nino')) {
      context.handle(_dosisNinoMeta,
          dosisNino.isAcceptableOrUnknown(data['dosis_nino']!, _dosisNinoMeta));
    }
    if (data.containsKey('alergias')) {
      context.handle(_alergiasMeta,
          alergias.isAcceptableOrUnknown(data['alergias']!, _alergiasMeta));
    }
    if (data.containsKey('contraindicaciones')) {
      context.handle(
          _contraindicacionesMeta,
          contraindicaciones.isAcceptableOrUnknown(
              data['contraindicaciones']!, _contraindicacionesMeta));
    }
    if (data.containsKey('enfermedades_incompatibles')) {
      context.handle(
          _enfermedadesIncompatiblesMeta,
          enfermedadesIncompatibles.isAcceptableOrUnknown(
              data['enfermedades_incompatibles']!,
              _enfermedadesIncompatiblesMeta));
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
          _actualizadoEnMeta,
          actualizadoEn.isAcceptableOrUnknown(
              data['actualizado_en']!, _actualizadoEnMeta));
    } else if (isInserting) {
      context.missing(_actualizadoEnMeta);
    }
    if (data.containsKey('eliminado')) {
      context.handle(_eliminadoMeta,
          eliminado.isAcceptableOrUnknown(data['eliminado']!, _eliminadoMeta));
    }
    if (data.containsKey('es_favorito')) {
      context.handle(
          _esFavoritoMeta,
          esFavorito.isAcceptableOrUnknown(
              data['es_favorito']!, _esFavoritoMeta));
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
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
      codigoBarras: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo_barras'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion']),
      fotoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}foto_url']),
      dosisAdulto: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosis_adulto']),
      dosisMayor: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosis_mayor']),
      dosisNino: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}dosis_nino']),
      alergias: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}alergias'])!,
      contraindicaciones: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}contraindicaciones'])!,
      enfermedadesIncompatibles: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}enfermedades_incompatibles'])!,
      actualizadoEn: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}actualizado_en'])!,
      eliminado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}eliminado'])!,
      esFavorito: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}es_favorito'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
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
  final String codigoBarras;
  final String nombre;
  final String? descripcion;
  final String? fotoUrl;
  final String? dosisAdulto;
  final String? dosisMayor;
  final String? dosisNino;
  final String alergias;
  final String contraindicaciones;
  final String enfermedadesIncompatibles;
  final DateTime actualizadoEn;
  final bool eliminado;
  final bool esFavorito;
  final bool sincronizado;
  const MedicamentosTableData(
      {required this.id,
      required this.codigoBarras,
      required this.nombre,
      this.descripcion,
      this.fotoUrl,
      this.dosisAdulto,
      this.dosisMayor,
      this.dosisNino,
      required this.alergias,
      required this.contraindicaciones,
      required this.enfermedadesIncompatibles,
      required this.actualizadoEn,
      required this.eliminado,
      required this.esFavorito,
      required this.sincronizado});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['codigo_barras'] = Variable<String>(codigoBarras);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    if (!nullToAbsent || fotoUrl != null) {
      map['foto_url'] = Variable<String>(fotoUrl);
    }
    if (!nullToAbsent || dosisAdulto != null) {
      map['dosis_adulto'] = Variable<String>(dosisAdulto);
    }
    if (!nullToAbsent || dosisMayor != null) {
      map['dosis_mayor'] = Variable<String>(dosisMayor);
    }
    if (!nullToAbsent || dosisNino != null) {
      map['dosis_nino'] = Variable<String>(dosisNino);
    }
    map['alergias'] = Variable<String>(alergias);
    map['contraindicaciones'] = Variable<String>(contraindicaciones);
    map['enfermedades_incompatibles'] =
        Variable<String>(enfermedadesIncompatibles);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    map['eliminado'] = Variable<bool>(eliminado);
    map['es_favorito'] = Variable<bool>(esFavorito);
    map['sincronizado'] = Variable<bool>(sincronizado);
    return map;
  }

  MedicamentosTableCompanion toCompanion(bool nullToAbsent) {
    return MedicamentosTableCompanion(
      id: Value(id),
      codigoBarras: Value(codigoBarras),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      fotoUrl: fotoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fotoUrl),
      dosisAdulto: dosisAdulto == null && nullToAbsent
          ? const Value.absent()
          : Value(dosisAdulto),
      dosisMayor: dosisMayor == null && nullToAbsent
          ? const Value.absent()
          : Value(dosisMayor),
      dosisNino: dosisNino == null && nullToAbsent
          ? const Value.absent()
          : Value(dosisNino),
      alergias: Value(alergias),
      contraindicaciones: Value(contraindicaciones),
      enfermedadesIncompatibles: Value(enfermedadesIncompatibles),
      actualizadoEn: Value(actualizadoEn),
      eliminado: Value(eliminado),
      esFavorito: Value(esFavorito),
      sincronizado: Value(sincronizado),
    );
  }

  factory MedicamentosTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicamentosTableData(
      id: serializer.fromJson<String>(json['id']),
      codigoBarras: serializer.fromJson<String>(json['codigoBarras']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      fotoUrl: serializer.fromJson<String?>(json['fotoUrl']),
      dosisAdulto: serializer.fromJson<String?>(json['dosisAdulto']),
      dosisMayor: serializer.fromJson<String?>(json['dosisMayor']),
      dosisNino: serializer.fromJson<String?>(json['dosisNino']),
      alergias: serializer.fromJson<String>(json['alergias']),
      contraindicaciones:
          serializer.fromJson<String>(json['contraindicaciones']),
      enfermedadesIncompatibles:
          serializer.fromJson<String>(json['enfermedadesIncompatibles']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
      eliminado: serializer.fromJson<bool>(json['eliminado']),
      esFavorito: serializer.fromJson<bool>(json['esFavorito']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'codigoBarras': serializer.toJson<String>(codigoBarras),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'fotoUrl': serializer.toJson<String?>(fotoUrl),
      'dosisAdulto': serializer.toJson<String?>(dosisAdulto),
      'dosisMayor': serializer.toJson<String?>(dosisMayor),
      'dosisNino': serializer.toJson<String?>(dosisNino),
      'alergias': serializer.toJson<String>(alergias),
      'contraindicaciones': serializer.toJson<String>(contraindicaciones),
      'enfermedadesIncompatibles':
          serializer.toJson<String>(enfermedadesIncompatibles),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
      'eliminado': serializer.toJson<bool>(eliminado),
      'esFavorito': serializer.toJson<bool>(esFavorito),
      'sincronizado': serializer.toJson<bool>(sincronizado),
    };
  }

  MedicamentosTableData copyWith(
          {String? id,
          String? codigoBarras,
          String? nombre,
          Value<String?> descripcion = const Value.absent(),
          Value<String?> fotoUrl = const Value.absent(),
          Value<String?> dosisAdulto = const Value.absent(),
          Value<String?> dosisMayor = const Value.absent(),
          Value<String?> dosisNino = const Value.absent(),
          String? alergias,
          String? contraindicaciones,
          String? enfermedadesIncompatibles,
          DateTime? actualizadoEn,
          bool? eliminado,
          bool? esFavorito,
          bool? sincronizado}) =>
      MedicamentosTableData(
        id: id ?? this.id,
        codigoBarras: codigoBarras ?? this.codigoBarras,
        nombre: nombre ?? this.nombre,
        descripcion: descripcion.present ? descripcion.value : this.descripcion,
        fotoUrl: fotoUrl.present ? fotoUrl.value : this.fotoUrl,
        dosisAdulto: dosisAdulto.present ? dosisAdulto.value : this.dosisAdulto,
        dosisMayor: dosisMayor.present ? dosisMayor.value : this.dosisMayor,
        dosisNino: dosisNino.present ? dosisNino.value : this.dosisNino,
        alergias: alergias ?? this.alergias,
        contraindicaciones: contraindicaciones ?? this.contraindicaciones,
        enfermedadesIncompatibles:
            enfermedadesIncompatibles ?? this.enfermedadesIncompatibles,
        actualizadoEn: actualizadoEn ?? this.actualizadoEn,
        eliminado: eliminado ?? this.eliminado,
        esFavorito: esFavorito ?? this.esFavorito,
        sincronizado: sincronizado ?? this.sincronizado,
      );
  MedicamentosTableData copyWithCompanion(MedicamentosTableCompanion data) {
    return MedicamentosTableData(
      id: data.id.present ? data.id.value : this.id,
      codigoBarras: data.codigoBarras.present
          ? data.codigoBarras.value
          : this.codigoBarras,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      fotoUrl: data.fotoUrl.present ? data.fotoUrl.value : this.fotoUrl,
      dosisAdulto:
          data.dosisAdulto.present ? data.dosisAdulto.value : this.dosisAdulto,
      dosisMayor:
          data.dosisMayor.present ? data.dosisMayor.value : this.dosisMayor,
      dosisNino: data.dosisNino.present ? data.dosisNino.value : this.dosisNino,
      alergias: data.alergias.present ? data.alergias.value : this.alergias,
      contraindicaciones: data.contraindicaciones.present
          ? data.contraindicaciones.value
          : this.contraindicaciones,
      enfermedadesIncompatibles: data.enfermedadesIncompatibles.present
          ? data.enfermedadesIncompatibles.value
          : this.enfermedadesIncompatibles,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
      eliminado: data.eliminado.present ? data.eliminado.value : this.eliminado,
      esFavorito:
          data.esFavorito.present ? data.esFavorito.value : this.esFavorito,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicamentosTableData(')
          ..write('id: $id, ')
          ..write('codigoBarras: $codigoBarras, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('fotoUrl: $fotoUrl, ')
          ..write('dosisAdulto: $dosisAdulto, ')
          ..write('dosisMayor: $dosisMayor, ')
          ..write('dosisNino: $dosisNino, ')
          ..write('alergias: $alergias, ')
          ..write('contraindicaciones: $contraindicaciones, ')
          ..write('enfermedadesIncompatibles: $enfermedadesIncompatibles, ')
          ..write('actualizadoEn: $actualizadoEn, ')
          ..write('eliminado: $eliminado, ')
          ..write('esFavorito: $esFavorito, ')
          ..write('sincronizado: $sincronizado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      codigoBarras,
      nombre,
      descripcion,
      fotoUrl,
      dosisAdulto,
      dosisMayor,
      dosisNino,
      alergias,
      contraindicaciones,
      enfermedadesIncompatibles,
      actualizadoEn,
      eliminado,
      esFavorito,
      sincronizado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicamentosTableData &&
          other.id == this.id &&
          other.codigoBarras == this.codigoBarras &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.fotoUrl == this.fotoUrl &&
          other.dosisAdulto == this.dosisAdulto &&
          other.dosisMayor == this.dosisMayor &&
          other.dosisNino == this.dosisNino &&
          other.alergias == this.alergias &&
          other.contraindicaciones == this.contraindicaciones &&
          other.enfermedadesIncompatibles == this.enfermedadesIncompatibles &&
          other.actualizadoEn == this.actualizadoEn &&
          other.eliminado == this.eliminado &&
          other.esFavorito == this.esFavorito &&
          other.sincronizado == this.sincronizado);
}

class MedicamentosTableCompanion
    extends UpdateCompanion<MedicamentosTableData> {
  final Value<String> id;
  final Value<String> codigoBarras;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<String?> fotoUrl;
  final Value<String?> dosisAdulto;
  final Value<String?> dosisMayor;
  final Value<String?> dosisNino;
  final Value<String> alergias;
  final Value<String> contraindicaciones;
  final Value<String> enfermedadesIncompatibles;
  final Value<DateTime> actualizadoEn;
  final Value<bool> eliminado;
  final Value<bool> esFavorito;
  final Value<bool> sincronizado;
  final Value<int> rowid;
  const MedicamentosTableCompanion({
    this.id = const Value.absent(),
    this.codigoBarras = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.fotoUrl = const Value.absent(),
    this.dosisAdulto = const Value.absent(),
    this.dosisMayor = const Value.absent(),
    this.dosisNino = const Value.absent(),
    this.alergias = const Value.absent(),
    this.contraindicaciones = const Value.absent(),
    this.enfermedadesIncompatibles = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
    this.eliminado = const Value.absent(),
    this.esFavorito = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicamentosTableCompanion.insert({
    required String id,
    required String codigoBarras,
    required String nombre,
    this.descripcion = const Value.absent(),
    this.fotoUrl = const Value.absent(),
    this.dosisAdulto = const Value.absent(),
    this.dosisMayor = const Value.absent(),
    this.dosisNino = const Value.absent(),
    this.alergias = const Value.absent(),
    this.contraindicaciones = const Value.absent(),
    this.enfermedadesIncompatibles = const Value.absent(),
    required DateTime actualizadoEn,
    this.eliminado = const Value.absent(),
    this.esFavorito = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        codigoBarras = Value(codigoBarras),
        nombre = Value(nombre),
        actualizadoEn = Value(actualizadoEn);
  static Insertable<MedicamentosTableData> custom({
    Expression<String>? id,
    Expression<String>? codigoBarras,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<String>? fotoUrl,
    Expression<String>? dosisAdulto,
    Expression<String>? dosisMayor,
    Expression<String>? dosisNino,
    Expression<String>? alergias,
    Expression<String>? contraindicaciones,
    Expression<String>? enfermedadesIncompatibles,
    Expression<DateTime>? actualizadoEn,
    Expression<bool>? eliminado,
    Expression<bool>? esFavorito,
    Expression<bool>? sincronizado,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (codigoBarras != null) 'codigo_barras': codigoBarras,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (fotoUrl != null) 'foto_url': fotoUrl,
      if (dosisAdulto != null) 'dosis_adulto': dosisAdulto,
      if (dosisMayor != null) 'dosis_mayor': dosisMayor,
      if (dosisNino != null) 'dosis_nino': dosisNino,
      if (alergias != null) 'alergias': alergias,
      if (contraindicaciones != null) 'contraindicaciones': contraindicaciones,
      if (enfermedadesIncompatibles != null)
        'enfermedades_incompatibles': enfermedadesIncompatibles,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
      if (eliminado != null) 'eliminado': eliminado,
      if (esFavorito != null) 'es_favorito': esFavorito,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicamentosTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? codigoBarras,
      Value<String>? nombre,
      Value<String?>? descripcion,
      Value<String?>? fotoUrl,
      Value<String?>? dosisAdulto,
      Value<String?>? dosisMayor,
      Value<String?>? dosisNino,
      Value<String>? alergias,
      Value<String>? contraindicaciones,
      Value<String>? enfermedadesIncompatibles,
      Value<DateTime>? actualizadoEn,
      Value<bool>? eliminado,
      Value<bool>? esFavorito,
      Value<bool>? sincronizado,
      Value<int>? rowid}) {
    return MedicamentosTableCompanion(
      id: id ?? this.id,
      codigoBarras: codigoBarras ?? this.codigoBarras,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      dosisAdulto: dosisAdulto ?? this.dosisAdulto,
      dosisMayor: dosisMayor ?? this.dosisMayor,
      dosisNino: dosisNino ?? this.dosisNino,
      alergias: alergias ?? this.alergias,
      contraindicaciones: contraindicaciones ?? this.contraindicaciones,
      enfermedadesIncompatibles:
          enfermedadesIncompatibles ?? this.enfermedadesIncompatibles,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
      eliminado: eliminado ?? this.eliminado,
      esFavorito: esFavorito ?? this.esFavorito,
      sincronizado: sincronizado ?? this.sincronizado,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (codigoBarras.present) {
      map['codigo_barras'] = Variable<String>(codigoBarras.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (fotoUrl.present) {
      map['foto_url'] = Variable<String>(fotoUrl.value);
    }
    if (dosisAdulto.present) {
      map['dosis_adulto'] = Variable<String>(dosisAdulto.value);
    }
    if (dosisMayor.present) {
      map['dosis_mayor'] = Variable<String>(dosisMayor.value);
    }
    if (dosisNino.present) {
      map['dosis_nino'] = Variable<String>(dosisNino.value);
    }
    if (alergias.present) {
      map['alergias'] = Variable<String>(alergias.value);
    }
    if (contraindicaciones.present) {
      map['contraindicaciones'] = Variable<String>(contraindicaciones.value);
    }
    if (enfermedadesIncompatibles.present) {
      map['enfermedades_incompatibles'] =
          Variable<String>(enfermedadesIncompatibles.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    if (eliminado.present) {
      map['eliminado'] = Variable<bool>(eliminado.value);
    }
    if (esFavorito.present) {
      map['es_favorito'] = Variable<bool>(esFavorito.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
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
          ..write('codigoBarras: $codigoBarras, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('fotoUrl: $fotoUrl, ')
          ..write('dosisAdulto: $dosisAdulto, ')
          ..write('dosisMayor: $dosisMayor, ')
          ..write('dosisNino: $dosisNino, ')
          ..write('alergias: $alergias, ')
          ..write('contraindicaciones: $contraindicaciones, ')
          ..write('enfermedadesIncompatibles: $enfermedadesIncompatibles, ')
          ..write('actualizadoEn: $actualizadoEn, ')
          ..write('eliminado: $eliminado, ')
          ..write('esFavorito: $esFavorito, ')
          ..write('sincronizado: $sincronizado, ')
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
  static const VerificationMeta _medicamentoNombreMeta =
      const VerificationMeta('medicamentoNombre');
  @override
  late final GeneratedColumn<String> medicamentoNombre =
      GeneratedColumn<String>('medicamento_nombre', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
      'fecha', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, medicamentoId, medicamentoNombre, tipo, fecha];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'historial_table';
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
    if (data.containsKey('medicamento_nombre')) {
      context.handle(
          _medicamentoNombreMeta,
          medicamentoNombre.isAcceptableOrUnknown(
              data['medicamento_nombre']!, _medicamentoNombreMeta));
    } else if (isInserting) {
      context.missing(_medicamentoNombreMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
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
      medicamentoNombre: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}medicamento_nombre'])!,
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
  final String medicamentoNombre;
  final String tipo;
  final DateTime fecha;
  const HistorialTableData(
      {required this.id,
      required this.medicamentoId,
      required this.medicamentoNombre,
      required this.tipo,
      required this.fecha});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['medicamento_id'] = Variable<String>(medicamentoId);
    map['medicamento_nombre'] = Variable<String>(medicamentoNombre);
    map['tipo'] = Variable<String>(tipo);
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  HistorialTableCompanion toCompanion(bool nullToAbsent) {
    return HistorialTableCompanion(
      id: Value(id),
      medicamentoId: Value(medicamentoId),
      medicamentoNombre: Value(medicamentoNombre),
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
      medicamentoNombre: serializer.fromJson<String>(json['medicamentoNombre']),
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
      'medicamentoNombre': serializer.toJson<String>(medicamentoNombre),
      'tipo': serializer.toJson<String>(tipo),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  HistorialTableData copyWith(
          {String? id,
          String? medicamentoId,
          String? medicamentoNombre,
          String? tipo,
          DateTime? fecha}) =>
      HistorialTableData(
        id: id ?? this.id,
        medicamentoId: medicamentoId ?? this.medicamentoId,
        medicamentoNombre: medicamentoNombre ?? this.medicamentoNombre,
        tipo: tipo ?? this.tipo,
        fecha: fecha ?? this.fecha,
      );
  HistorialTableData copyWithCompanion(HistorialTableCompanion data) {
    return HistorialTableData(
      id: data.id.present ? data.id.value : this.id,
      medicamentoId: data.medicamentoId.present
          ? data.medicamentoId.value
          : this.medicamentoId,
      medicamentoNombre: data.medicamentoNombre.present
          ? data.medicamentoNombre.value
          : this.medicamentoNombre,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistorialTableData(')
          ..write('id: $id, ')
          ..write('medicamentoId: $medicamentoId, ')
          ..write('medicamentoNombre: $medicamentoNombre, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, medicamentoId, medicamentoNombre, tipo, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistorialTableData &&
          other.id == this.id &&
          other.medicamentoId == this.medicamentoId &&
          other.medicamentoNombre == this.medicamentoNombre &&
          other.tipo == this.tipo &&
          other.fecha == this.fecha);
}

class HistorialTableCompanion extends UpdateCompanion<HistorialTableData> {
  final Value<String> id;
  final Value<String> medicamentoId;
  final Value<String> medicamentoNombre;
  final Value<String> tipo;
  final Value<DateTime> fecha;
  final Value<int> rowid;
  const HistorialTableCompanion({
    this.id = const Value.absent(),
    this.medicamentoId = const Value.absent(),
    this.medicamentoNombre = const Value.absent(),
    this.tipo = const Value.absent(),
    this.fecha = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HistorialTableCompanion.insert({
    required String id,
    required String medicamentoId,
    required String medicamentoNombre,
    required String tipo,
    required DateTime fecha,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        medicamentoId = Value(medicamentoId),
        medicamentoNombre = Value(medicamentoNombre),
        tipo = Value(tipo),
        fecha = Value(fecha);
  static Insertable<HistorialTableData> custom({
    Expression<String>? id,
    Expression<String>? medicamentoId,
    Expression<String>? medicamentoNombre,
    Expression<String>? tipo,
    Expression<DateTime>? fecha,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicamentoId != null) 'medicamento_id': medicamentoId,
      if (medicamentoNombre != null) 'medicamento_nombre': medicamentoNombre,
      if (tipo != null) 'tipo': tipo,
      if (fecha != null) 'fecha': fecha,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HistorialTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? medicamentoId,
      Value<String>? medicamentoNombre,
      Value<String>? tipo,
      Value<DateTime>? fecha,
      Value<int>? rowid}) {
    return HistorialTableCompanion(
      id: id ?? this.id,
      medicamentoId: medicamentoId ?? this.medicamentoId,
      medicamentoNombre: medicamentoNombre ?? this.medicamentoNombre,
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
    if (medicamentoNombre.present) {
      map['medicamento_nombre'] = Variable<String>(medicamentoNombre.value);
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
          ..write('medicamentoNombre: $medicamentoNombre, ')
          ..write('tipo: $tipo, ')
          ..write('fecha: $fecha, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTableTable extends SyncQueueTable
    with TableInfo<$SyncQueueTableTable, SyncQueueTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operacionMeta =
      const VerificationMeta('operacion');
  @override
  late final GeneratedColumn<String> operacion = GeneratedColumn<String>(
      'operacion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creadoEnMeta =
      const VerificationMeta('creadoEn');
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
      'creado_en', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sincronizadoMeta =
      const VerificationMeta('sincronizado');
  @override
  late final GeneratedColumn<bool> sincronizado = GeneratedColumn<bool>(
      'sincronizado', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("sincronizado" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, operacion, creadoEn, sincronizado];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue_table';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('operacion')) {
      context.handle(_operacionMeta,
          operacion.isAcceptableOrUnknown(data['operacion']!, _operacionMeta));
    } else if (isInserting) {
      context.missing(_operacionMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(_creadoEnMeta,
          creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta));
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    if (data.containsKey('sincronizado')) {
      context.handle(
          _sincronizadoMeta,
          sincronizado.isAcceptableOrUnknown(
              data['sincronizado']!, _sincronizadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      operacion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operacion'])!,
      creadoEn: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creado_en'])!,
      sincronizado: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}sincronizado'])!,
    );
  }

  @override
  $SyncQueueTableTable createAlias(String alias) {
    return $SyncQueueTableTable(attachedDatabase, alias);
  }
}

class SyncQueueTableData extends DataClass
    implements Insertable<SyncQueueTableData> {
  final String id;
  final String operacion;
  final DateTime creadoEn;
  final bool sincronizado;
  const SyncQueueTableData(
      {required this.id,
      required this.operacion,
      required this.creadoEn,
      required this.sincronizado});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['operacion'] = Variable<String>(operacion);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['sincronizado'] = Variable<bool>(sincronizado);
    return map;
  }

  SyncQueueTableCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueTableCompanion(
      id: Value(id),
      operacion: Value(operacion),
      creadoEn: Value(creadoEn),
      sincronizado: Value(sincronizado),
    );
  }

  factory SyncQueueTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueTableData(
      id: serializer.fromJson<String>(json['id']),
      operacion: serializer.fromJson<String>(json['operacion']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      sincronizado: serializer.fromJson<bool>(json['sincronizado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'operacion': serializer.toJson<String>(operacion),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'sincronizado': serializer.toJson<bool>(sincronizado),
    };
  }

  SyncQueueTableData copyWith(
          {String? id,
          String? operacion,
          DateTime? creadoEn,
          bool? sincronizado}) =>
      SyncQueueTableData(
        id: id ?? this.id,
        operacion: operacion ?? this.operacion,
        creadoEn: creadoEn ?? this.creadoEn,
        sincronizado: sincronizado ?? this.sincronizado,
      );
  SyncQueueTableData copyWithCompanion(SyncQueueTableCompanion data) {
    return SyncQueueTableData(
      id: data.id.present ? data.id.value : this.id,
      operacion: data.operacion.present ? data.operacion.value : this.operacion,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      sincronizado: data.sincronizado.present
          ? data.sincronizado.value
          : this.sincronizado,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableData(')
          ..write('id: $id, ')
          ..write('operacion: $operacion, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('sincronizado: $sincronizado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, operacion, creadoEn, sincronizado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueTableData &&
          other.id == this.id &&
          other.operacion == this.operacion &&
          other.creadoEn == this.creadoEn &&
          other.sincronizado == this.sincronizado);
}

class SyncQueueTableCompanion extends UpdateCompanion<SyncQueueTableData> {
  final Value<String> id;
  final Value<String> operacion;
  final Value<DateTime> creadoEn;
  final Value<bool> sincronizado;
  final Value<int> rowid;
  const SyncQueueTableCompanion({
    this.id = const Value.absent(),
    this.operacion = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.sincronizado = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueTableCompanion.insert({
    required String id,
    required String operacion,
    required DateTime creadoEn,
    this.sincronizado = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        operacion = Value(operacion),
        creadoEn = Value(creadoEn);
  static Insertable<SyncQueueTableData> custom({
    Expression<String>? id,
    Expression<String>? operacion,
    Expression<DateTime>? creadoEn,
    Expression<bool>? sincronizado,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operacion != null) 'operacion': operacion,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (sincronizado != null) 'sincronizado': sincronizado,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? operacion,
      Value<DateTime>? creadoEn,
      Value<bool>? sincronizado,
      Value<int>? rowid}) {
    return SyncQueueTableCompanion(
      id: id ?? this.id,
      operacion: operacion ?? this.operacion,
      creadoEn: creadoEn ?? this.creadoEn,
      sincronizado: sincronizado ?? this.sincronizado,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (operacion.present) {
      map['operacion'] = Variable<String>(operacion.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (sincronizado.present) {
      map['sincronizado'] = Variable<bool>(sincronizado.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueTableCompanion(')
          ..write('id: $id, ')
          ..write('operacion: $operacion, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('sincronizado: $sincronizado, ')
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
  late final $HistorialTableTable historialTable = $HistorialTableTable(this);
  late final $SyncQueueTableTable syncQueueTable = $SyncQueueTableTable(this);
  late final MedicamentosDao medicamentosDao =
      MedicamentosDao(this as AppDatabase);
  late final HistorialDao historialDao = HistorialDao(this as AppDatabase);
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [medicamentosTable, historialTable, syncQueueTable];
}

typedef $$MedicamentosTableTableCreateCompanionBuilder
    = MedicamentosTableCompanion Function({
  required String id,
  required String codigoBarras,
  required String nombre,
  Value<String?> descripcion,
  Value<String?> fotoUrl,
  Value<String?> dosisAdulto,
  Value<String?> dosisMayor,
  Value<String?> dosisNino,
  Value<String> alergias,
  Value<String> contraindicaciones,
  Value<String> enfermedadesIncompatibles,
  required DateTime actualizadoEn,
  Value<bool> eliminado,
  Value<bool> esFavorito,
  Value<bool> sincronizado,
  Value<int> rowid,
});
typedef $$MedicamentosTableTableUpdateCompanionBuilder
    = MedicamentosTableCompanion Function({
  Value<String> id,
  Value<String> codigoBarras,
  Value<String> nombre,
  Value<String?> descripcion,
  Value<String?> fotoUrl,
  Value<String?> dosisAdulto,
  Value<String?> dosisMayor,
  Value<String?> dosisNino,
  Value<String> alergias,
  Value<String> contraindicaciones,
  Value<String> enfermedadesIncompatibles,
  Value<DateTime> actualizadoEn,
  Value<bool> eliminado,
  Value<bool> esFavorito,
  Value<bool> sincronizado,
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

  ColumnFilters<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fotoUrl => $composableBuilder(
      column: $table.fotoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosisAdulto => $composableBuilder(
      column: $table.dosisAdulto, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosisMayor => $composableBuilder(
      column: $table.dosisMayor, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dosisNino => $composableBuilder(
      column: $table.dosisNino, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get alergias => $composableBuilder(
      column: $table.alergias, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get contraindicaciones => $composableBuilder(
      column: $table.contraindicaciones,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get enfermedadesIncompatibles => $composableBuilder(
      column: $table.enfermedadesIncompatibles,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
      column: $table.actualizadoEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get eliminado => $composableBuilder(
      column: $table.eliminado, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get esFavorito => $composableBuilder(
      column: $table.esFavorito, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fotoUrl => $composableBuilder(
      column: $table.fotoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosisAdulto => $composableBuilder(
      column: $table.dosisAdulto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosisMayor => $composableBuilder(
      column: $table.dosisMayor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dosisNino => $composableBuilder(
      column: $table.dosisNino, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get alergias => $composableBuilder(
      column: $table.alergias, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get contraindicaciones => $composableBuilder(
      column: $table.contraindicaciones,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get enfermedadesIncompatibles => $composableBuilder(
      column: $table.enfermedadesIncompatibles,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
      column: $table.actualizadoEn,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get eliminado => $composableBuilder(
      column: $table.eliminado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get esFavorito => $composableBuilder(
      column: $table.esFavorito, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get codigoBarras => $composableBuilder(
      column: $table.codigoBarras, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<String> get fotoUrl =>
      $composableBuilder(column: $table.fotoUrl, builder: (column) => column);

  GeneratedColumn<String> get dosisAdulto => $composableBuilder(
      column: $table.dosisAdulto, builder: (column) => column);

  GeneratedColumn<String> get dosisMayor => $composableBuilder(
      column: $table.dosisMayor, builder: (column) => column);

  GeneratedColumn<String> get dosisNino =>
      $composableBuilder(column: $table.dosisNino, builder: (column) => column);

  GeneratedColumn<String> get alergias =>
      $composableBuilder(column: $table.alergias, builder: (column) => column);

  GeneratedColumn<String> get contraindicaciones => $composableBuilder(
      column: $table.contraindicaciones, builder: (column) => column);

  GeneratedColumn<String> get enfermedadesIncompatibles => $composableBuilder(
      column: $table.enfermedadesIncompatibles, builder: (column) => column);

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
      column: $table.actualizadoEn, builder: (column) => column);

  GeneratedColumn<bool> get eliminado =>
      $composableBuilder(column: $table.eliminado, builder: (column) => column);

  GeneratedColumn<bool> get esFavorito => $composableBuilder(
      column: $table.esFavorito, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);
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
            Value<String> codigoBarras = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String?> descripcion = const Value.absent(),
            Value<String?> fotoUrl = const Value.absent(),
            Value<String?> dosisAdulto = const Value.absent(),
            Value<String?> dosisMayor = const Value.absent(),
            Value<String?> dosisNino = const Value.absent(),
            Value<String> alergias = const Value.absent(),
            Value<String> contraindicaciones = const Value.absent(),
            Value<String> enfermedadesIncompatibles = const Value.absent(),
            Value<DateTime> actualizadoEn = const Value.absent(),
            Value<bool> eliminado = const Value.absent(),
            Value<bool> esFavorito = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicamentosTableCompanion(
            id: id,
            codigoBarras: codigoBarras,
            nombre: nombre,
            descripcion: descripcion,
            fotoUrl: fotoUrl,
            dosisAdulto: dosisAdulto,
            dosisMayor: dosisMayor,
            dosisNino: dosisNino,
            alergias: alergias,
            contraindicaciones: contraindicaciones,
            enfermedadesIncompatibles: enfermedadesIncompatibles,
            actualizadoEn: actualizadoEn,
            eliminado: eliminado,
            esFavorito: esFavorito,
            sincronizado: sincronizado,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String codigoBarras,
            required String nombre,
            Value<String?> descripcion = const Value.absent(),
            Value<String?> fotoUrl = const Value.absent(),
            Value<String?> dosisAdulto = const Value.absent(),
            Value<String?> dosisMayor = const Value.absent(),
            Value<String?> dosisNino = const Value.absent(),
            Value<String> alergias = const Value.absent(),
            Value<String> contraindicaciones = const Value.absent(),
            Value<String> enfermedadesIncompatibles = const Value.absent(),
            required DateTime actualizadoEn,
            Value<bool> eliminado = const Value.absent(),
            Value<bool> esFavorito = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MedicamentosTableCompanion.insert(
            id: id,
            codigoBarras: codigoBarras,
            nombre: nombre,
            descripcion: descripcion,
            fotoUrl: fotoUrl,
            dosisAdulto: dosisAdulto,
            dosisMayor: dosisMayor,
            dosisNino: dosisNino,
            alergias: alergias,
            contraindicaciones: contraindicaciones,
            enfermedadesIncompatibles: enfermedadesIncompatibles,
            actualizadoEn: actualizadoEn,
            eliminado: eliminado,
            esFavorito: esFavorito,
            sincronizado: sincronizado,
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
typedef $$HistorialTableTableCreateCompanionBuilder = HistorialTableCompanion
    Function({
  required String id,
  required String medicamentoId,
  required String medicamentoNombre,
  required String tipo,
  required DateTime fecha,
  Value<int> rowid,
});
typedef $$HistorialTableTableUpdateCompanionBuilder = HistorialTableCompanion
    Function({
  Value<String> id,
  Value<String> medicamentoId,
  Value<String> medicamentoNombre,
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

  ColumnFilters<String> get medicamentoNombre => $composableBuilder(
      column: $table.medicamentoNombre,
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

  ColumnOrderings<String> get medicamentoNombre => $composableBuilder(
      column: $table.medicamentoNombre,
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

  GeneratedColumn<String> get medicamentoNombre => $composableBuilder(
      column: $table.medicamentoNombre, builder: (column) => column);

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
            Value<String> medicamentoNombre = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<DateTime> fecha = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HistorialTableCompanion(
            id: id,
            medicamentoId: medicamentoId,
            medicamentoNombre: medicamentoNombre,
            tipo: tipo,
            fecha: fecha,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String medicamentoId,
            required String medicamentoNombre,
            required String tipo,
            required DateTime fecha,
            Value<int> rowid = const Value.absent(),
          }) =>
              HistorialTableCompanion.insert(
            id: id,
            medicamentoId: medicamentoId,
            medicamentoNombre: medicamentoNombre,
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
typedef $$SyncQueueTableTableCreateCompanionBuilder = SyncQueueTableCompanion
    Function({
  required String id,
  required String operacion,
  required DateTime creadoEn,
  Value<bool> sincronizado,
  Value<int> rowid,
});
typedef $$SyncQueueTableTableUpdateCompanionBuilder = SyncQueueTableCompanion
    Function({
  Value<String> id,
  Value<String> operacion,
  Value<DateTime> creadoEn,
  Value<bool> sincronizado,
  Value<int> rowid,
});

class $$SyncQueueTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operacion => $composableBuilder(
      column: $table.operacion, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
      column: $table.creadoEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => ColumnFilters(column));
}

class $$SyncQueueTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operacion => $composableBuilder(
      column: $table.operacion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
      column: $table.creadoEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado,
      builder: (column) => ColumnOrderings(column));
}

class $$SyncQueueTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTableTable> {
  $$SyncQueueTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operacion =>
      $composableBuilder(column: $table.operacion, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<bool> get sincronizado => $composableBuilder(
      column: $table.sincronizado, builder: (column) => column);
}

class $$SyncQueueTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueTableData,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueTableData,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>
    ),
    SyncQueueTableData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableTableManager(
      _$AppDatabase db, $SyncQueueTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> operacion = const Value.absent(),
            Value<DateTime> creadoEn = const Value.absent(),
            Value<bool> sincronizado = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueTableCompanion(
            id: id,
            operacion: operacion,
            creadoEn: creadoEn,
            sincronizado: sincronizado,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String operacion,
            required DateTime creadoEn,
            Value<bool> sincronizado = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncQueueTableCompanion.insert(
            id: id,
            operacion: operacion,
            creadoEn: creadoEn,
            sincronizado: sincronizado,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncQueueTableTable,
    SyncQueueTableData,
    $$SyncQueueTableTableFilterComposer,
    $$SyncQueueTableTableOrderingComposer,
    $$SyncQueueTableTableAnnotationComposer,
    $$SyncQueueTableTableCreateCompanionBuilder,
    $$SyncQueueTableTableUpdateCompanionBuilder,
    (
      SyncQueueTableData,
      BaseReferences<_$AppDatabase, $SyncQueueTableTable, SyncQueueTableData>
    ),
    SyncQueueTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MedicamentosTableTableTableManager get medicamentosTable =>
      $$MedicamentosTableTableTableManager(_db, _db.medicamentosTable);
  $$HistorialTableTableTableManager get historialTable =>
      $$HistorialTableTableTableManager(_db, _db.historialTable);
  $$SyncQueueTableTableTableManager get syncQueueTable =>
      $$SyncQueueTableTableTableManager(_db, _db.syncQueueTable);
}
