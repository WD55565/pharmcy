import 'package:flutter/material.dart';

/// Brand-neutral seed palette. Swap [seed] for a real brand color once one
/// is chosen — every other color in the theme derives from it via
/// [ColorScheme.fromSeed].
abstract final class AppColors {
  static const Color seed = Color(0xFF2E7D6B);
  static const Color error = Color(0xFFBA1A1A);
}
