import 'package:flutter/material.dart';

class FitLogColors extends ThemeExtension<FitLogColors> {
  final Color background;
  final Color surfaceCard;
  final Color surfaceElevated;
  final Color neonAccent;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;

  const FitLogColors({
    required this.background,
    required this.surfaceCard,
    required this.surfaceElevated,
    required this.neonAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
  });

  static const FitLogColors dark = FitLogColors(
    background: Color(0xFF0F0F0F),
    surfaceCard: Color(0xFF111111),
    surfaceElevated: Color(0xFF141414),
    neonAccent: Color(0xFFD4FF00),
    textPrimary: Colors.white,
    textSecondary: Color(0xFF8A8A8A),
    border: Color(0xFF2A2A2A),
  );

  static const FitLogColors light = FitLogColors(
    background: Color(0xFFF5F5F5),
    surfaceCard: Colors.white,
    surfaceElevated: Color(0xFFEEEEEE),
    neonAccent: Color(0xFF6B8E00),
    textPrimary: Color(0xFF121212),
    textSecondary: Color(0xFF666666),
    border: Color(0xFFE0E0E0),
  );

  @override
  FitLogColors copyWith({
    Color? background,
    Color? surfaceCard,
    Color? surfaceElevated,
    Color? neonAccent,
    Color? textPrimary,
    Color? textSecondary,
    Color? border,
  }) {
    return FitLogColors(
      background: background ?? this.background,
      surfaceCard: surfaceCard ?? this.surfaceCard,
      surfaceElevated: surfaceElevated ?? this.surfaceElevated,
      neonAccent: neonAccent ?? this.neonAccent,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      border: border ?? this.border,
    );
  }

  @override
  FitLogColors lerp(ThemeExtension<FitLogColors>? other, double t) {
    if (other is! FitLogColors) return this;
    return FitLogColors(
      background: Color.lerp(background, other.background, t)!,
      surfaceCard: Color.lerp(surfaceCard, other.surfaceCard, t)!,
      surfaceElevated: Color.lerp(surfaceElevated, other.surfaceElevated, t)!,
      neonAccent: Color.lerp(neonAccent, other.neonAccent, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}

class AppTheme {
  static const String themePrefKey = 'app_theme_mode';

  static FitLogColors colorsOf(BuildContext context) {
    return Theme.of(context).extension<FitLogColors>() ?? FitLogColors.dark;
  }

  static ThemeData darkTheme() {
    const colors = FitLogColors.dark;
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.neonAccent,
        onPrimary: colors.background,
        secondary: colors.neonAccent,
        onSecondary: colors.background,
        surface: colors.surfaceCard,
        onSurface: colors.textPrimary,
        error: Colors.redAccent,
      ),
      textTheme: _textTheme(colors),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: colors.neonAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardColor: colors.surfaceCard,
      dividerColor: colors.border,
      canvasColor: colors.background,
      drawerTheme: DrawerThemeData(
        backgroundColor: colors.surfaceCard,
        scrimColor: Colors.black.withValues(alpha: 0.55),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceElevated,
        titleTextStyle: TextStyle(
          color: colors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(color: colors.textPrimary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.background,
        selectedItemColor: colors.neonAccent,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
      ),
      inputDecorationTheme: _inputDecorationTheme(colors),
      elevatedButtonTheme: _elevatedButtonTheme(colors),
      outlinedButtonTheme: _outlinedButtonTheme(colors),
      textButtonTheme: _textButtonTheme(colors),
      iconTheme: IconThemeData(color: colors.textPrimary),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surfaceElevated,
        contentTextStyle: TextStyle(color: colors.textPrimary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colors.neonAccent
              : colors.textSecondary,
        ),
      ),
      extensions: const [FitLogColors.dark],
    );
  }

  static ThemeData lightTheme() {
    const colors = FitLogColors.light;
    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.light(
        primary: colors.neonAccent,
        onPrimary: Colors.white,
        secondary: colors.neonAccent,
        onSecondary: Colors.white,
        surface: colors.surfaceCard,
        onSurface: colors.textPrimary,
        error: Colors.redAccent,
      ),
      textTheme: _textTheme(colors),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: colors.neonAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardColor: colors.surfaceCard,
      dividerColor: colors.border,
      canvasColor: colors.background,
      drawerTheme: DrawerThemeData(
        backgroundColor: colors.surfaceCard,
        scrimColor: Colors.black.withValues(alpha: 0.25),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surfaceCard,
        titleTextStyle: TextStyle(
          color: colors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(color: colors.textPrimary),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.background,
        selectedItemColor: colors.neonAccent,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
      ),
      inputDecorationTheme: _inputDecorationTheme(colors),
      elevatedButtonTheme: _elevatedButtonTheme(colors),
      outlinedButtonTheme: _outlinedButtonTheme(colors),
      textButtonTheme: _textButtonTheme(colors),
      iconTheme: IconThemeData(color: colors.textPrimary),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surfaceElevated,
        contentTextStyle: TextStyle(color: colors.textPrimary),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colors.neonAccent
              : colors.textSecondary,
        ),
      ),
      extensions: const [FitLogColors.light],
    );
  }

  static TextTheme _textTheme(FitLogColors colors) {
    return TextTheme(
      bodyLarge: TextStyle(color: colors.textPrimary),
      bodyMedium: TextStyle(color: colors.textPrimary),
      bodySmall: TextStyle(color: colors.textSecondary),
      titleLarge: TextStyle(color: colors.textPrimary),
      titleMedium: TextStyle(color: colors.textPrimary),
      titleSmall: TextStyle(color: colors.textPrimary),
      labelLarge: TextStyle(color: colors.textPrimary),
      labelMedium: TextStyle(color: colors.textSecondary),
      labelSmall: TextStyle(color: colors.textSecondary),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(FitLogColors colors) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colors.surfaceElevated,
      labelStyle: TextStyle(color: colors.textSecondary),
      hintStyle: TextStyle(color: colors.textSecondary),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.neonAccent),
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(FitLogColors colors) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.neonAccent,
        foregroundColor: colors.background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(FitLogColors colors) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.neonAccent,
        side: BorderSide(color: colors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(FitLogColors colors) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: colors.neonAccent),
    );
  }
}
