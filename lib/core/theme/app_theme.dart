import 'package:flutter/material.dart';
import 'vital_track_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: VitalTrackColors.primary,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: VitalTrackColors.background,
      
      // Card Theme: elevation 0 and Outline border
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),

      // TextFormField Theme: OutlineInputBorder and filled
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),

      // SnackBar Theme (Default values, specific error style will be a helper)
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),

      // Typography
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }
}
