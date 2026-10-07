import 'package:medicamentos_app/domain/entities/audit_log.dart';
import 'package:medicamentos_app/domain/entities/medicamento.dart';
import 'package:uuid/uuid.dart';

class AuditHelper {
  AuditHelper._();

  static const _uuid = Uuid();

  static AuditLog crear({
    required String usuarioNombre,
    required String dispositivoId,
    required String accion,
    required String registroId,
    Map<String, dynamic>? datosAntes,
    Map<String, dynamic>? datosDespues,
  }) {
    return AuditLog(
      id: _uuid.v4(),
      usuarioNombre: usuarioNombre,
      dispositivoId: dispositivoId,
      accion: accion,
      tabla: 'medicamentos',
      registroId: registroId,
      datosAntes: datosAntes,
      datosDespues: datosDespues,
      fecha: DateTime.now(),
    );
  }

  static Map<String, dynamic> medicamentoToMap(Medicamento m) {
    return {
      'id': m.id,
      'nombre': m.nombre,
      'codigo_barras': m.codigoBarras,
      'descripcion': m.descripcion,
      'dosis_adulto': m.dosisAdulto,
      'dosis_mayor': m.dosisMayor,
      'dosis_nino': m.dosisNino,
      'alergias': m.alergias,
      'contraindicaciones': m.contraindicaciones,
      'enfermedades_incompatibles': m.enfermedadesIncompatibles,
    };
  }
}