import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/presentation/providers/connectivity_provider.dart';

class SyncIndicator extends ConsumerWidget {
  const SyncIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conectado = ref.watch(isConnectedProvider);

    return conectado.when(
      data: (online) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            online ? Icons.cloud_done_rounded : Icons.cloud_off_rounded,
            size: 16,
            color: online ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            online ? 'Sincronizado' : 'Sin conexión',
            style: TextStyle(
              fontSize: 12,
              color: online ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
      loading: () => const SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      error: (_, __) => const Icon(Icons.cloud_off, size: 16, color: Colors.red),
    );
  }
}