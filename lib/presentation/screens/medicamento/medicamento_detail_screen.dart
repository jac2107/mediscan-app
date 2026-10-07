import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicamentos_app/core/constants/app_constants.dart';
import 'package:medicamentos_app/presentation/providers/favoritos_provider.dart';

class MedicamentoDetailScreen extends ConsumerWidget {
  final String medicamentoId;

  const MedicamentoDetailScreen({super.key, required this.medicamentoId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medAsync = ref.watch(medicamentoPorIdProvider(medicamentoId));

    return medAsync.when(
      data: (med) {
        if (med == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Medicamento no encontrado')),
          );
        }
        return _DetalleView(med: med);
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(
        body: Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _DetalleView extends ConsumerStatefulWidget {
  final MedicamentosTableData med;

  const _DetalleView({required this.med});

  @override
  ConsumerState<_DetalleView> createState() => _DetalleViewState();
}

class _DetalleViewState extends ConsumerState<_DetalleView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late bool _esFavorito;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _esFavorito = widget.med.esFavorito;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _toggleFavorito() async {
    final dao = ref.read(medicamentosDaoProvider);
    final nuevoValor = !_esFavorito;
    await dao.toggleFavorito(widget.med.id, nuevoValor);
    setState(() => _esFavorito = nuevoValor);
    ref.invalidate(favoritosProvider);
  }

  Future<void> _eliminar() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Eliminar medicamento'),
        content: Text(
          '¿Estás seguro de eliminar "${widget.med.nombre}"? Esta acción se registrará en el audit log.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmar != true || !mounted) return;

    final dao = ref.read(medicamentosDaoProvider);
    final prefs = await SharedPreferences.getInstance();
    final usuarioNombre =
        prefs.getString(AppConstants.keyUsuarioNombre) ?? 'Desconocido';

    await dao.eliminar(widget.med.id);
    ref.invalidate(todosMedicamentosProvider);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.med.nombre} eliminado por $usuarioNombre'),
          backgroundColor: Colors.red,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final med = widget.med;
    final alergias = AppDatabase.jsonToList(med.alergias);
    final contraindicaciones = AppDatabase.jsonToList(med.contraindicaciones);
    final enfermedades =
        AppDatabase.jsonToList(med.enfermedadesIncompatibles);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          med.nombre,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: Icon(
              _esFavorito ? Icons.star_rounded : Icons.star_outline_rounded,
              color: _esFavorito ? Colors.amber : null,
            ),
            onPressed: _toggleFavorito,
            tooltip: _esFavorito ? 'Quitar favorito' : 'Agregar a favoritos',
          ),
          IconButton(
            icon: const Icon(Icons.edit_rounded),
            onPressed: () => context.push(
              '${Routes.formularioMedicamento}?id=${med.id}',
            ),
            tooltip: 'Editar',
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            onPressed: _eliminar,
            tooltip: 'Eliminar',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Dosis'),
            Tab(text: 'Alergias'),
            Tab(text: 'Contraind.'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Header con foto o ícono
          Container(
            width: double.infinity,
            color: theme.colorScheme.primaryContainer.withOpacity(0.3),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Foto o ícono
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: med.fotoUrl != null
                      ? Image.network(
                          med.fotoUrl!,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              _IconoMedicamento(size: 72),
                        )
                      : _IconoMedicamento(size: 72),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        med.nombre,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (med.descripcion != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          med.descripcion!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      const SizedBox(height: 4),
                      Text(
                        'Cód: ${med.codigoBarras}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Tabs
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Tab Dosis
                _TabDosis(med: med),

                // Tab Alergias
                _TabLista(
                  items: alergias,
                  icono: Icons.warning_amber_rounded,
                  color: Colors.orange,
                  emptyText: 'No se registraron alergias',
                ),

                // Tab Contraindicaciones
                _TabLista(
                  items: [...contraindicaciones, ...enfermedades],
                  icono: Icons.block_rounded,
                  color: Colors.red,
                  emptyText: 'No se registraron contraindicaciones',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconoMedicamento extends StatelessWidget {
  final double size;

  const _IconoMedicamento({required this.size});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.medication_rounded,
        size: size * 0.6,
        color: theme.colorScheme.primary,
      ),
    );
  }
}

class _TabDosis extends StatelessWidget {
  final MedicamentosTableData med;

  const _TabDosis({required this.med});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _DosisCard(
          titulo: 'Adultos',
          dosis: med.dosisAdulto,
          icono: Icons.person_rounded,
          color: Colors.blue,
        ),
        const SizedBox(height: 12),
        _DosisCard(
          titulo: 'Adultos mayores',
          dosis: med.dosisMayor,
          icono: Icons.elderly_rounded,
          color: Colors.purple,
        ),
        const SizedBox(height: 12),
        _DosisCard(
          titulo: 'Niños',
          dosis: med.dosisNino,
          icono: Icons.child_care_rounded,
          color: Colors.green,
        ),
      ],
    );
  }
}

class _DosisCard extends StatelessWidget {
  final String titulo;
  final String? dosis;
  final IconData icono;
  final Color color;

  const _DosisCard({
    required this.titulo,
    required this.dosis,
    required this.icono,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icono, color: color, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dosis ?? 'No especificada',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: dosis == null
                          ? theme.colorScheme.onSurfaceVariant
                          : null,
                      fontStyle:
                          dosis == null ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabLista extends StatelessWidget {
  final List<String> items;
  final IconData icono;
  final Color color;
  final String emptyText;

  const _TabLista({
    required this.items,
    required this.icono,
    required this.color,
    required this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_outline_rounded,
                size: 48, color: Colors.green),
            const SizedBox(height: 8),
            Text(
              emptyText,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Icon(icono, color: color, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  items[index],
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}