enum TipoAcceso { busqueda, escaneo }

class HistorialItem {
  final String id;
  final String medicamentoId;
  final String medicamentoNombre;
  final TipoAcceso tipo;
  final DateTime fecha;

  const HistorialItem({
    required this.id,
    required this.medicamentoId,
    required this.medicamentoNombre,
    required this.tipo,
    required this.fecha,
  });
}