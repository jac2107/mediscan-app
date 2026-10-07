import 'package:flutter/material.dart';
class MedicamentoDetailScreen extends StatelessWidget {
  final String medicamentoId;
  const MedicamentoDetailScreen({super.key, required this.medicamentoId});
  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: Text('Detalle')));
}
