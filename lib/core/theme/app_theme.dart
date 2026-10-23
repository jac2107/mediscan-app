import 'package:flutter/material.dart';
import 'package:medicamentos_app/core/theme/app_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Tokens de paleta editorial ────────────────────────────────
  static const Color bgMarfil = Color(0xFFFBF8EF);
  static const Color surface = Color(0xFFECEDE5);
  static const Color ink = Color(0xFF262B28);
  static const Color muted = Color(0xFF626862);
  static const Color verde = Color(0xFF123D2F);
  static const Color green700 = Color(0xFF1F5A44);
  static const Color mint = Color(0xFF9FD9B8);
  static const Color card = Color(0xFFFFFDF7);
  static const double radiusCard = 24;
  static const double radiusControl = 20;
  static const double radiusChip = 14;
  static const Color border = Color(0xFFD2DACF);
  static const Color colorError = Color(0xFFA52E22);
  static const Color colorWarn = Color(0xFF755629);
  static const Color disabled = Color(0xFFDCE0D7);

  static TextTheme _buildTextTheme() => TextTheme(
    // Lora – titulares y nombres
    displayLarge: AppFonts.lora(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.28,
    ),
    displayMedium: AppFonts.lora(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.36,
    ),
    displaySmall: AppFonts.lora(
      fontSize: 21,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.38,
    ),
    headlineLarge: AppFonts.lora(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.36,
    ),
    headlineMedium: AppFonts.lora(
      fontSize: 21,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.38,
    ),
    headlineSmall: AppFonts.lora(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.44,
    ),
    titleLarge: AppFonts.lora(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.40,
    ),
    // Inter – cuerpo, controles y datos
    titleMedium: AppFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: ink,
      height: 1.50,
    ),
    titleSmall: AppFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: ink,
      height: 1.50,
    ),
    bodyLarge: AppFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.50,
    ),
    bodyMedium: AppFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: ink,
      height: 1.50,
    ),
    bodySmall: AppFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: muted,
      height: 1.50,
    ),
    labelLarge: AppFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: ink,
      height: 1.43,
    ),
    labelMedium: AppFonts.inter(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: ink,
      height: 1.43,
    ),
    labelSmall: AppFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: muted,
      height: 1.50,
    ),
  );

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: verde,
        onPrimary: bgMarfil,
        primaryContainer: surface,
        onPrimaryContainer: ink,
        secondary: muted,
        onSecondary: bgMarfil,
        secondaryContainer: surface,
        onSecondaryContainer: ink,
        tertiary: colorWarn,
        onTertiary: bgMarfil,
        tertiaryContainer: surface,
        onTertiaryContainer: colorWarn,
        error: colorError,
        onError: bgMarfil,
        errorContainer: surface,
        onErrorContainer: colorError,
        surface: bgMarfil,
        onSurface: ink,
        surfaceContainerHighest: surface,
        onSurfaceVariant: muted,
        outline: border,
        outlineVariant: border,
        scrim: Color(0x80000000),
        inverseSurface: ink,
        onInverseSurface: bgMarfil,
        inversePrimary: surface,
      ),
      scaffoldBackgroundColor: bgMarfil,
      fontFamily: 'Inter',
      hoverColor: verde.withValues(alpha: 0.06),
      focusColor: verde.withValues(alpha: 0.12),
      highlightColor: verde.withValues(alpha: 0.10),
      splashColor: verde.withValues(alpha: 0.10),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
          foregroundColor: const WidgetStatePropertyAll(verde),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.focused)
                  ? verde
                  : Colors.transparent,
              width: 2,
            ),
          ),
          shape: const WidgetStatePropertyAll(CircleBorder()),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: bgMarfil,
        indicatorColor: surface,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => AppFonts.inter(
            fontSize: 12,
            color: states.contains(WidgetState.selected) ? verde : muted,
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
      ),
      textTheme: _buildTextTheme(),

      // ── AppBar ──────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: bgMarfil,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: AppFonts.lora(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: ink,
        ),
        iconTheme: const IconThemeData(color: ink),
        actionsIconTheme: const IconThemeData(color: ink),
      ),

      // ── Card: sin sombra, borde sutil, radio mínimo ─────────
      cardTheme: CardThemeData(
        elevation: 0,
        color: card,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
          side: const BorderSide(color: border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      // ── Separadores ─────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: border,
        thickness: 1,
        space: 1,
      ),
      dividerColor: border,

      // ── Botón primario (verde / marfil) ──────────────────────
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.disabled) ? disabled : verde,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.disabled) ? muted : bgMarfil,
          ),
          minimumSize: const WidgetStatePropertyAll(Size(64, 48)),
          elevation: const WidgetStatePropertyAll(0),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.focused)
                  ? ink
                  : Colors.transparent,
              width: 2,
            ),
          ),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radiusControl)),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            AppFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      // ── Botón secundario ─────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(verde),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: verde,
              width: states.contains(WidgetState.focused) ? 2 : 1,
            ),
          ),
          minimumSize: const WidgetStatePropertyAll(Size(64, 48)),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radiusControl)),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            AppFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      // ── TextButton ───────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(
              color: states.contains(WidgetState.focused)
                  ? verde
                  : Colors.transparent,
              width: 2,
            ),
          ),
          foregroundColor: const WidgetStatePropertyAll(verde),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(radiusControl)),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            AppFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      // ── Campos de texto ──────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        constraints: const BoxConstraints(minHeight: 56),
        filled: true,
        fillColor: card,
        labelStyle: AppFonts.inter(fontSize: 14, color: muted),
        hintStyle: AppFonts.inter(fontSize: 14, color: muted),
        errorStyle: AppFonts.inter(fontSize: 12, color: colorError),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: verde, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: colorError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusControl),
          borderSide: const BorderSide(color: colorError, width: 2),
        ),
      ),

      // ── ListTile ─────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        tileColor: bgMarfil,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        titleTextStyle: AppFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: ink,
        ),
        subtitleTextStyle: AppFonts.inter(fontSize: 13, color: muted),
        iconColor: muted,
      ),

      // ── Dialog ───────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: bgMarfil,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppFonts.lora(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: ink,
        ),
        contentTextStyle: AppFonts.inter(fontSize: 14, color: ink),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),

      // ── SnackBar ─────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: surface,
        contentTextStyle: AppFonts.inter(fontSize: 14, color: ink),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusControl),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // ── TabBar ───────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelStyle: AppFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: AppFonts.inter(fontSize: 13),
        labelColor: verde,
        unselectedLabelColor: muted,
        indicatorColor: verde,
        dividerColor: border,
        indicatorSize: TabBarIndicatorSize.tab,
      ),

      // ── BottomSheet ──────────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: bgMarfil,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
      ),

      // ── Chips ────────────────────────────────────────────────
      expansionTileTheme: ExpansionTileThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
          side: const BorderSide(color: border),
        ),
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusCard),
          side: const BorderSide(color: border),
        ),
        backgroundColor: card,
        collapsedBackgroundColor: card,
        iconColor: verde,
        collapsedIconColor: green700,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: verde,
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: AppFonts.inter(fontSize: 12, color: bgMarfil),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: verde,
        checkmarkColor: bgMarfil,
        showCheckmark: true,
        labelStyle: AppFonts.inter(fontSize: 13, color: ink),
        secondaryLabelStyle: AppFonts.inter(fontSize: 13, color: bgMarfil),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radiusChip)),
          side: BorderSide(color: border),
        ),
      ),
    );
  }
}
