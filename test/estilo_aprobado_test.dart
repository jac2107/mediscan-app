import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medicamentos_app/core/theme/app_theme.dart';
import 'package:medicamentos_app/presentation/providers/medicamentos_provider.dart';
import 'package:medicamentos_app/presentation/widgets/common/favorite_button.dart';
import 'package:medicamentos_app/presentation/widgets/common/voice_panel.dart';
import 'package:medicamentos_app/presentation/widgets/medicamento/dosis_tab.dart';
import 'package:medicamentos_app/presentation/widgets/medicamento/image_viewer.dart';
import 'package:medicamentos_app/presentation/widgets/filtros/filtros_sheet.dart';

Widget host(Widget body, {bool reduce = true, double scale = 1}) => MaterialApp(
      theme: AppTheme.light,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(
            disableAnimations: reduce, textScaler: TextScaler.linear(scale)),
        child: child!,
      ),
      home: Scaffold(body: body),
    );

void main() {
  test('Conserva Lora/Inter y el crema de la versión actual', () {
    final theme = AppTheme.light;
    expect(theme.textTheme.titleLarge!.fontFamily, 'Lora');
    expect(theme.textTheme.bodyMedium!.fontFamily, 'Inter');
    expect(theme.scaffoldBackgroundColor, const Color(0xFFFBF8EF));
  });

  testWidgets(
    'Favoritos: hover, foco, pulsación y deshabilitado sin cambiar tamaño',
    (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        host(
          Center(
            child: FavoriteButton(selected: false, onPressed: () => taps++),
          ),
        ),
      );
      final button = find.byType(IconButton);
      final original = tester.getRect(button);
      expect(original.size, const Size(48, 48));
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: Offset.zero);
      await mouse.moveTo(original.center);
      await tester.pumpAndSettle();
      expect(tester.getRect(button), original);
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();
      expect(tester.getRect(button), original);
      final touch = await tester.startGesture(original.center);
      await tester.pump(const Duration(milliseconds: 120));
      expect(tester.getRect(button), original);
      await touch.up();
      await tester.pumpAndSettle();
      expect(taps, 1);
      await tester.pumpWidget(
        host(const Center(child: FavoriteButton(selected: true))),
      );
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      expect(taps, 1);
      expect(tester.getRect(find.byType(IconButton)).size, original.size);
      await mouse.removePointer();
      expect(tester.takeException(), isNull);
    },
  );

  for (final width in [320.0, 390.0, 1024.0]) {
    testWidgets('Dosis, aviso de voz y controles con texto grande a $width px',
        (
      tester,
    ) async {
      tester.view.physicalSize = Size(width, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      const original =
          '0,5 mg/kg/dosis; conservar las unidades, los límites y esta advertencia.\nNo aplica según la presentación registrada.';
      await tester.pumpWidget(
        host(
          const DosisTab(
            adultos: original,
            mayores: original,
            pediatrica: original,
            lactantes: original,
          ),
          scale: 1.8,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text(original), findsWidgets);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(
        host(
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: VoicePanel(
                transcript: 'Paracetamol, nombre completo reconocido',
                level: 1,
                onCancel: () {},
              ),
            ),
          ),
          scale: 1.8,
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.text('Paracetamol, nombre completo reconocido'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets(
    'Micrófono: área fija, anillos dentro de límites y movimiento reducido',
    (tester) async {
      await tester.pumpWidget(
        host(
          Center(
            child: VoiceButton(listening: true, busy: false, onPressed: () {}),
          ),
          reduce: false,
        ),
      );
      final before = tester.getRect(find.byType(VoiceButton));
      expect(before.size, const Size(72, 72));
      await tester.pump(const Duration(milliseconds: 700));
      expect(tester.getRect(find.byType(VoiceButton)), before);
      for (final finder in [
        find.descendant(
            of: find.byType(VoiceButton), matching: find.byType(Transform))
      ]) {
        for (final element in finder.evaluate()) {
          final render = (element.renderObject! as RenderTransform).child!;
          final rect = MatrixUtils.transformRect(
            render.getTransformTo(null),
            render.paintBounds,
          );
          expect(rect.left, greaterThanOrEqualTo(before.left - 1));
          expect(rect.right, lessThanOrEqualTo(before.right + 1));
          expect(rect.top, greaterThanOrEqualTo(before.top - 1));
          expect(rect.bottom, lessThanOrEqualTo(before.bottom + 1));
        }
      }
      await tester.pumpWidget(
        host(const Center(child: VoiceButton(listening: true, busy: false))),
      );
      await tester.pumpAndSettle();
      expect(tester.binding.transientCallbackCount, 0);
      await tester.pumpWidget(
        host(const Center(child: VoiceButton(listening: false, busy: true))),
      );
      await tester.pump();
      expect(
        tester.widget<IconButton>(find.byType(IconButton)).onPressed,
        isNull,
      );
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Visor: borde verde y cierre visible tras un error de imagen', (
    tester,
  ) async {
    await tester.pumpWidget(
      host(
        Builder(
          builder: (context) => TextButton(
            onPressed: () => abrirImagenMedicamento(
              context,
              'https://example.invalid/imagen.png',
              'Nombre largo del medicamento',
            ),
            child: const Text('Abrir'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Abrir'));
    await tester.pumpAndSettle();
    final box = tester.widget<Container>(
      find.byKey(const Key('visor-borde-verde')),
    );
    final decoration = box.decoration! as BoxDecoration;
    final border = decoration.border! as Border;
    expect(border.top.color, AppTheme.verde);
    expect(border.top.width, 2);
    expect(find.text('No pudimos cargar la imagen.'), findsOneWidget);
    await tester.tap(find.byTooltip('Cerrar imagen'));
    await tester.pumpAndSettle();
    expect(find.byType(Dialog), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Filtros: expandir, seleccionar, contraer y limpiar conserva el criterio',
    (tester) async {
      final options = List.generate(13, (i) => 'Categoría ${i + 1}');
      final container = ProviderContainer(
        overrides: [
          opcionesFiltrosProvider.overrideWith(
            (ref) async => {'categorias': options},
          ),
        ],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: host(const FiltrosSheet()),
        ),
      );
      await tester.pumpAndSettle();
      final expand = find.text('Ver todos (13)');
      await tester.scrollUntilVisible(expand, 250,
          scrollable: find.byType(Scrollable).first);
      await Scrollable.ensureVisible(tester.element(expand), alignment: .5);
      await tester.pumpAndSettle();
      await tester.tap(expand);
      await tester.pumpAndSettle();
      final last = find.text('Categoría 13');
      await Scrollable.ensureVisible(tester.element(last), alignment: .5);
      await tester.pumpAndSettle();
      await tester.tap(last);
      await tester.pumpAndSettle();
      expect(
        container.read(filtrosProvider).categorias,
        contains('Categoría 13'),
      );
      final collapse = find.text('Ver menos');
      await Scrollable.ensureVisible(tester.element(collapse), alignment: .5);
      await tester.pumpAndSettle();
      await tester.tap(collapse);
      await tester.pumpAndSettle();
      expect(find.text('Categoría 13'), findsNothing);
      expect(
        container.read(filtrosProvider).categorias,
        contains('Categoría 13'),
      );
      await tester.tap(find.text('Limpiar'));
      await tester.pumpAndSettle();
      expect(container.read(filtrosProvider).categorias, isEmpty);
      expect(tester.takeException(), isNull);
    },
  );
}
