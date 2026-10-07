class AuditLog {
  final String id;
  final String usuarioNombre;
  final String dispositivoId;
  final String accion; // 'CREAR' | 'EDITAR' | 'ELIMINAR'
  final String tabla;
  final String registroId;
  final Map<String, dynamic>? datosAntes;
  final Map<String, dynamic>? datosDespues;
  final DateTime fecha;

  const AuditLog({
    required this.id,
    required this.usuarioNombre,
    required this.dispositivoId,
    required this.accion,
    required this.tabla,
    required this.registroId,
    this.datosAntes,
    this.datosDespues,
    required this.fecha,
  });
}