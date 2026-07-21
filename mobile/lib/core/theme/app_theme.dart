import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Central place for light/dark [ThemeData]. Feature UI should read colors
/// and text styles from `Theme.of(context)` rather than hardcoding values.
abstract final class AppTheme {
  static ThemeData get light => _themeFor(Brightness.light);

  static ThemeData get dark => _themeFor(Brightness.dark);

  static ThemeData _themeFor(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.seed,
      brightness: brightness,
      error: AppColors.error,
    );

    final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
    const buttonPadding = EdgeInsets.symmetric(horizontal: 24, vertical: 14);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      // The app exclusively uses FilledButton/OutlinedButton (not the
      // plain ElevatedButton), so all three are themed identically for a
      // consistent, deliberately-rounded look rather than relying on
      // Material's slightly-less-rounded defaults.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(padding: buttonPadding, shape: buttonShape),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(padding: buttonPadding, shape: buttonShape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(padding: buttonPadding, shape: buttonShape),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      searchBarTheme: SearchBarThemeData(
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainerHigh),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      chipTheme: ChipThemeData(shape: StadiumBorder(side: BorderSide(color: colorScheme.outlineVariant))),
    );
  }
}
