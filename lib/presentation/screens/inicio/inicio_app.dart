import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/sync_provider.dart';

class ResultadoInicio {
  final bool remotoDisponible;
  const ResultadoInicio({this.remotoDisponible = true});
}

class InicioApp extends StatefulWidget {
  final Future<ResultadoInicio> Function() inicializar;
  const InicioApp({super.key, required this.inicializar});
  @override
  State<InicioApp> createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> {
  late Future<ResultadoInicio> _inicio;
  bool _abrirLocal = false;
  @override
  void initState() {
    super.initState();
    _inicio = widget.inicializar();
  }

  void _reintentar() => setState(() {
    _abrirLocal = false;
    _inicio = widget.inicializar();
  });
  @override
  Widget build(BuildContext context) => FutureBuilder<ResultadoInicio>(
    future: _inicio,
    builder: (context, snapshot) {
      final listo =
          snapshot.connectionState == ConnectionState.done &&
          !snapshot.hasError;
      if (listo && (snapshot.data!.remotoDisponible || _abrirLocal)) {
        if (!snapshot.data!.remotoDisponible)
          return ProviderScope(
            overrides: [
              syncProvider.overrideWith(() => _SyncLocal(_reintentar)),
            ],
            child: const MedicamentosApp(sincronizar: false),
          );
        return const MedicamentosApp();
      }
      final error =
          snapshot.connectionState == ConnectionState.done &&
          (snapshot.hasError || (listo && !snapshot.data!.remotoDisponible));
      return MaterialApp(
        title: 'Farmafolio',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/brand/farmafolio-logo.png',
                        width: 260,
                        semanticLabel: 'Farmafolio',
                      ),
                      const SizedBox(height: 24),
                      Semantics(
                        liveRegion: true,
                        child: Text(
                          error
                              ? (snapshot.hasError
                                    ? 'No pudimos preparar el catálogo.'
                                    : 'El servicio de sincronización no está disponible.')
                              : 'Preparando tu catálogo…',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (!error)
                        const CircularProgressIndicator(strokeWidth: 2),
                      if (error) ...[
                        if (!snapshot.hasError) ...[
                          const Text(
                            'Tus medicamentos guardados están disponibles sin conexión.',
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          FilledButton(
                            onPressed: () => setState(() => _abrirLocal = true),
                            child: const Text('Abrir catálogo sin conexión'),
                          ),
                        ],
                        TextButton(
                          onPressed: _reintentar,
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _SyncLocal extends SyncNotifier {
  final VoidCallback reintentar;
  _SyncLocal(this.reintentar);
  @override
  EstadoSync build() => EstadoSync.offline;
  @override
  void syncManual() => reintentar();
}
