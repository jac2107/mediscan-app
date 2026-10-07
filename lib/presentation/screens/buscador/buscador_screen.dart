import 'package:flutter/material.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/presentation/providers/historial_provider.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';
import 'package:uuid/uuid.dart';

class BuscadorScreen extends ConsumerStatefulWidget {
  const BuscadorScreen({super.key});

  @override
  ConsumerState<BuscadorScreen> createState() => _BuscadorScreenState();
}

class _BuscadorScreenState extends ConsumerState<BuscadorScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  static const _uuid = Uuid();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onQueryChanged(String value) {
    ref.read(busquedaQueryProvider.notifier).state = value;
  }

  void _limpiar() {
    _controller.clear();
    ref.read(busquedaQueryProvider.notifier).state = '';
    _focusNode.requestFocus();
  }

  Future<void> _abrirMedicamento(MedicamentosTableData med) async {
    // Guardar en historial
    final dao = ref.read(historialDaoProvider);
    await dao.agregar(HistorialTableCompanion(
      id: Value(_uuid.v4()),
      medicamentoId: Value(med.id),
      medicamentoNombre: Value(med.nombre),
      tipo: const Value('busqueda'),
      fecha: Value(DateTime.now()),
    ));
    ref.invalidate(historialProvider);

    if (mounted) {
      context.push(Routes.detalleMedicamento.replaceAll(':id', med.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final query = ref.watch(busquedaQueryProvider);
    final sugerenciasAsync = ref.watch(sugerenciasProvider);
    final historialAsync = ref.watch(historialProvider);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          onChanged: _onQueryChanged,
          decoration: InputDecoration(
            hintText: 'Buscar medicamento...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            suffixIcon: query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: _limpiar,
                  )
                : null,
          ),
        ),
      ),
      body: query.isEmpty
          ? _HistorialReciente(
              historialAsync: historialAsync,
              onTap: (med) => _abrirMedicamento(med),
            )
          : sugerenciasAsync.when(
              data: (lista) {
                if (lista.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant
                              .withOpacity(0.4),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Sin resultados para "$query"',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: lista.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final med = lista[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            theme.colorScheme.primaryContainer,
                        child: Icon(
                          Icons.medication_rounded,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      title: _TextoResaltado(
                        texto: med.nombre,
                        query: query,
                      ),
                      subtitle: med.descripcion != null
                          ? Text(
                              med.descripcion!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : null,
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => _abrirMedicamento(med),
                    );
                  },
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
    );
  }
}

// Widget que resalta el texto buscado en el resultado
class _TextoResaltado extends StatelessWidget {
  final String texto;
  final String query;

  const _TextoResaltado({required this.texto, required this.query});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (query.isEmpty) return Text(texto);

    final lowerTexto = texto.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final index = lowerTexto.indexOf(lowerQuery);

    if (index == -1) return Text(texto);

    return RichText(
      text: TextSpan(
        style: theme.textTheme.bodyLarge,
        children: [
          if (index > 0)
            TextSpan(text: texto.substring(0, index)),
          TextSpan(
            text: texto.substring(index, index + query.length),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          if (index + query.length < texto.length)
            TextSpan(text: texto.substring(index + query.length)),
        ],
      ),
    );
  }
}

// Historial reciente cuando no hay búsqueda activa
class _HistorialReciente extends ConsumerWidget {
  final AsyncValue<List<HistorialTableData>> historialAsync;
  final void Function(MedicamentosTableData) onTap;

  const _HistorialReciente({
    required this.historialAsync,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return historialAsync.when(
      data: (historial) {
        if (historial.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.manage_search_rounded,
                  size: 64,
                  color: theme.colorScheme.onSurfaceVariant.withOpacity(0.4),
                ),
                const SizedBox(height: 12),
                Text(
                  'Aún no hay búsquedas recientes',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text(
                'Búsquedas recientes',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: historial.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = historial[index];
                  return ListTile(
                    leading: Icon(
                      item.tipo == 'escaneo'
                          ? Icons.qr_code_scanner_rounded
                          : Icons.history_rounded,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    title: Text(item.medicamentoNombre),
                    trailing: const Icon(
                      Icons.north_west_rounded,
                      size: 16,
                    ),
                    onTap: () async {
                      final dao = ref.read(medicamentosDaoProvider);
                      final todos = await dao.getAll();
                      try {
                        final med = todos.firstWhere(
                            (m) => m.id == item.medicamentoId);
                        onTap(med);
                      } catch (_) {}
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}