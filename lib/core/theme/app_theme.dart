import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // ── Tokens de paleta editorial ────────────────────────────────
  static const Color bgMarfil   = Color(0xFFFBF8EF);
  static const Color surface    = Color(0xFFECEDE5);
  static const Color ink        = Color(0xFF262B28);
  static const Color muted      = Color(0xFF626862);
  static const Color verde      = Color(0xFF304B40);
  static const Color border     = Color(0xFFB4BCB2);
  static const Color colorError = Color(0xFFA52E22);
  static const Color colorWarn  = Color(0xFF755629);
  static const Color disabled   = Color(0xFFDCE0D7);

  static TextTheme _buildTextTheme() => TextTheme(
        // Lora – titulares y nombres
        displayLarge:   GoogleFonts.lora(fontSize: 36, fontWeight: FontWeight.w400, color: ink, height: 1.28),
        displayMedium:  GoogleFonts.lora(fontSize: 28, fontWeight: FontWeight.w400, color: ink, height: 1.36),
        displaySmall:   GoogleFonts.lora(fontSize: 21, fontWeight: FontWeight.w400, color: ink, height: 1.38),
        headlineLarge:  GoogleFonts.lora(fontSize: 28, fontWeight: FontWeight.w400, color: ink, height: 1.36),
        headlineMedium: GoogleFonts.lora(fontSize: 21, fontWeight: FontWeight.w400, color: ink, height: 1.38),
        headlineSmall:  GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w400, color: ink, height: 1.44),
        titleLarge:     GoogleFonts.lora(fontSize: 20, fontWeight: FontWeight.w400, color: ink, height: 1.40),
        // Inter – cuerpo, controles y datos
        titleMedium:    GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: ink, height: 1.50),
        titleSmall:     GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: ink, height: 1.50),
        bodyLarge:      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400, color: ink, height: 1.50),
        bodyMedium:     GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: ink, height: 1.50),
        bodySmall:      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, color: muted, height: 1.50),
        labelLarge:     GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: ink, height: 1.43),
        labelMedium:    GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: ink, height: 1.43),
        labelSmall:     GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: muted, height: 1.50),
      );

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
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
        tertiaryContainer: Color(0xFFF5EBE0),
        onTertiaryContainer: colorWarn,
        error: colorError,
        onError: bgMarfil,
        errorContainer: Color(0xFFFDE8E6),
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
      textTheme: _buildTextTheme(),

      // ── AppBar ──────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: bgMarfil,
        foregroundColor: ink,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.lora(
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
        color: bgMarfil,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
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
          backgroundColor: WidgetStateProperty.resolveWith((s) =>
              s.contains(WidgetState.disabled) ? disabled : verde),
          foregroundColor: WidgetStateProperty.resolveWith((s) =>
              s.contains(WidgetState.disabled) ? muted : bgMarfil),
          minimumSize: const WidgetStatePropertyAll(Size(64, 48)),
          elevation: const WidgetStatePropertyAll(0),
          shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          )),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      // ── Botón secundario ─────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(verde),
          side: const WidgetStatePropertyAll(BorderSide(color: verde)),
          minimumSize: const WidgetStatePropertyAll(Size(64, 48)),
          shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          )),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      // ── TextButton ───────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(verde),
          shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          )),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ),

      // ── Campos de texto ──────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: bgMarfil,
        labelStyle: GoogleFonts.inter(fontSize: 14, color: muted),
        hintStyle: GoogleFonts.inter(fontSize: 14, color: border),
        errorStyle: GoogleFonts.inter(fontSize: 12, color: colorError),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: verde, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: colorError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: const BorderSide(color: colorError, width: 2),
        ),
      ),

      // ── ListTile ─────────────────────────────────────────────
      listTileTheme: ListTileThemeData(
        tileColor: bgMarfil,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        titleTextStyle: GoogleFonts.inter(
            fontSize: 16, fontWeight: FontWeight.w500, color: ink),
        subtitleTextStyle: GoogleFonts.inter(fontSize: 13, color: muted),
        iconColor: muted,
      ),

      // ── Dialog ───────────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: bgMarfil,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.lora(
            fontSize: 18, fontWeight: FontWeight.w400, color: ink),
        contentTextStyle: GoogleFonts.inter(fontSize: 14, color: ink),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // ── SnackBar ─────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ink,
        contentTextStyle: GoogleFonts.inter(fontSize: 14, color: bgMarfil),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        behavior: SnackBarBehavior.floating,
      ),

      // ── TabBar ───────────────────────────────────────────────
      tabBarTheme: TabBarThemeData(
        labelStyle:
            GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 13),
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ),

      // ── Chips ────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: surface,
        selectedColor: verde,
        labelStyle: GoogleFonts.inter(fontSize: 13, color: ink),
        secondaryLabelStyle: GoogleFonts.inter(fontSize: 13, color: bgMarfil),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          side: BorderSide(color: border),
        ),
      ),
    );
  }
}