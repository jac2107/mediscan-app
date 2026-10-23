import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/data/models/medicamento_model.dart';

void main() {
  late AppDatabase db;
  setUp(() { db = AppDatabase.forTesting(NativeDatabase.memory()); });
  tearDown(() => db.close());
  Map<String,dynamic> row(String id) => {'id':id,'codigo_interno':'MED-$id','nombre_comercial':'Nombre $id','categoria':'["Vitaminas"]','laboratorios':['A','B'],'foto_path':'foto.png'};
  MedicamentosTableCompanion companion(String id) => MedicamentoModel.toCompanion(row(id),publicImageUrl:(path)=>'https://storage.test/$path');
  test('instantánea retira bajas de catálogo, favoritos y acceso directo', () async {
    await db.aplicarCatalogoPublico([companion('1'),companion('2')]);
    await db.toggleFavorito('2',true);
    await db.aplicarCatalogoPublico([companion('1')]);
    expect((await db.getAllMedicamentos()).map((m)=>m.id),['1']);
    expect(await db.getMedicamentoById('2'),isNull);
    expect(await db.getFavoritos(),isEmpty);
    await db.aplicarCatalogoPublico([companion('1'),companion('2')]);
    expect((await db.getAllMedicamentos()).length,2);
    expect((await db.getMedicamentoById('2'))!.codigoInterno,'MED-2');
  });
  test('actualización conserva favoritos de medicamentos vigentes y no duplica',() async {
    await db.aplicarCatalogoPublico([companion('1')]);await db.toggleFavorito('1',true);
    await db.aplicarCatalogoPublico([companion('1')]);
    expect((await db.getFavoritos()).length,1);expect((await db.getAllMedicamentos()).length,1);
  });
  test('un conflicto revierte escrituras y conserva el catálogo previo',() async {
    await db.aplicarCatalogoPublico([companion('1')]);
    final conflict=companion('2').copyWith(codigoInterno:const Value('MED-1'));
    await expectLater(db.aplicarCatalogoPublico([companion('3'),conflict]),throwsA(anything));
    expect((await db.getAllMedicamentos()).map((m)=>m.id),['1']);
  });
  test('una instantánea vacía confirmada retira todas las fichas',() async {
    await db.aplicarCatalogoPublico([companion('1')]);await db.aplicarCatalogoPublico([]);
    expect(await db.getAllMedicamentos(),isEmpty);
  });
  test('mapper usa foto_path o fuentes, conserva arreglos y rechaza formato inválido',() {
    expect(companion('1').fotoUrl.value,'https://storage.test/foto.png');
    final source=row('2')..['foto_path']=null..['medicamento_fuentes']=[{'imagen_origen_url':'https://source.test/photo.png'}];
    expect(MedicamentoModel.toCompanion(source,publicImageUrl:(p)=>p).fotoUrl.value,'https://source.test/photo.png');
    expect(()=>MedicamentoModel.toCompanion(row('3')..['laboratorios']='A,B',publicImageUrl:(p)=>p),throwsFormatException);
  });
}
