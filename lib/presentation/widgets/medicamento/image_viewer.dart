import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';

Future<void> abrirImagenMedicamento(
  BuildContext context,
  String url,
  String nombre,
) => showDialog<void>(
  context: context,
  barrierColor: AppTheme.ink.withValues(alpha: .6),
  barrierLabel: 'Cerrar imagen ampliada',
  builder: (context) => Shortcuts(
    shortcuts: const {
      SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
    },
    child: Actions(
      actions: {
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (_) {
            Navigator.of(context).pop();
            return null;
          },
        ),
      },
      child: Dialog.fullscreen(
        backgroundColor: AppTheme.bgMarfil,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Tooltip(
                        message: nombre,
                        child: Text(
                          nombre,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ),
                    IconButton(
                      autofocus: true,
                      tooltip: 'Cerrar imagen',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Image.network(
                      url,
                      fit: BoxFit.contain,
                      semanticLabel: 'Imagen ampliada de $nombre',
                      loadingBuilder: (_, child, progress) => progress == null
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                      errorBuilder: (_, __, ___) => const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.broken_image_outlined,
                            size: 48,
                            color: AppTheme.muted,
                          ),
                          SizedBox(height: 16),
                          Text('No pudimos cargar la imagen.'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
