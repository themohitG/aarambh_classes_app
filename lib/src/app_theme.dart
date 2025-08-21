import 'package:flutter/material.dart';

class AppTheme {
  // Colors: black/white with accent red (#FF1C1C) to match tagline
  static const Color primary = Color(0xFF111111);
  static const Color accent = Color(0xFFFF1C1C);
  static const Color surface = Colors.white;

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
    );

    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: primary,
        secondary: accent,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        foregroundColor: primary,
        elevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      cardTheme: CardThemeData(   // ✅ FIXED
        color: surface,
        elevation: 0.5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),
    );
  }
}
