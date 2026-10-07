import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:medicamentos_app/data/local/database/app_database.dart';
import 'package:medicamentos_app/presentation/providers/historial_provider.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/router/routes.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _procesando = false;
  static const _uuid = Uuid();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_procesando) return;
    final barcode = capture.barcodes.firstOrNull;
    if (barcode?.rawValue == null) return;

    setState(() => _procesando = true);
    final codigo = barcode!.rawValue!;

    final dao = ref.read(medicamentosDaoProvider);
    final med = await dao.buscarPorCodigo(codigo);

    if (!mounted) return;

    if (med != null) {
      // Guardar en historial
      final historialDao = ref.read(historialDaoProvider);
      await historialDao.agregar(HistorialTableCompanion(
        id: Value(_uuid.v4()),
        medicamentoId: Value(med.id),
        medicamentoNombre: Value(med.nombre),
        tipo: const Value('escaneo'),
        fecha: Value(DateTime.now()),
      ));
      ref.invalidate(historialProvider);

      if (mounted) {
        context.pushReplacement(
          Routes.detalleMedicamento.replaceAll(':id', med.id),
        );
      }
    } else {
      // No encontrado
      _mostrarNoEncontrado(codigo);
      setState(() => _procesando = false);
    }
  }

  void _mostrarNoEncontrado(String codigo) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off_rounded, size: 48, color: Colors.orange),
            const SizedBox(height: 12),
            const Text(
              'Medicamento no encontrado',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Código: $codigo',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  context.push(
                    '${Routes.formularioMedicamento}?codigo=$codigo',
                  );
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text('Agregar este medicamento'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Seguir escaneando'),
              ),
            ),
          ],
        ),
      ),
    ).whenComplete(() => setState(() => _procesando = false));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear medicamento'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on_rounded),
            onPressed: () => _controller.toggleTorch(),
            tooltip: 'Linterna',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Cámara
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
          ),

          // Overlay con marco
          CustomPaint(
            painter: _ScannerOverlayPainter(
              borderColor: theme.colorScheme.primary,
            ),
            child: const SizedBox.expand(),
          ),

          // Texto inferior
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Apunta al código de barras del medicamento',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (_procesando) ...[
                  const SizedBox(height: 16),
                  const CircularProgressIndicator(color: Colors.white),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Marco del escáner
class _ScannerOverlayPainter extends CustomPainter {
  final Color borderColor;

  _ScannerOverlayPainter({required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    final scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 40),
      width: size.width * 0.75,
      height: 150,
    );

    // Oscurecer fuera del marco
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(12))),
      ),
      paint,
    );

    // Esquinas del marco
    final cornerPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLen = 24.0;
    final l = scanRect.left;
    final t = scanRect.top;
    final r = scanRect.right;
    final b = scanRect.bottom;

    // Esquina superior izquierda
    canvas.drawLine(Offset(l, t + cornerLen), Offset(l, t), cornerPaint);
    canvas.drawLine(Offset(l, t), Offset(l + cornerLen, t), cornerPaint);
    // Esquina superior derecha
    canvas.drawLine(Offset(r - cornerLen, t), Offset(r, t), cornerPaint);
    canvas.drawLine(Offset(r, t), Offset(r, t + cornerLen), cornerPaint);
    // Esquina inferior izquierda
    canvas.drawLine(Offset(l, b - cornerLen), Offset(l, b), cornerPaint);
    canvas.drawLine(Offset(l, b), Offset(l + cornerLen, b), cornerPaint);
    // Esquina inferior derecha
    canvas.drawLine(Offset(r - cornerLen, b), Offset(r, b), cornerPaint);
    canvas.drawLine(Offset(r, b), Offset(r, b - cornerLen), cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}