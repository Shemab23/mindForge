import 'package:flutter/material.dart';

class AppTheme {
  // 1. Private Constructor to prevent instantiation
  AppTheme._();

  // 2. Global Color Tokens (Your CSS variables)
  static const Color backgroundDark = Color(0xFF02025E);
  static const Color surfaceDark = Color(0xFF1A1A2E);
  static const Color primaryPurple = Color(0xFF8A2BE2);
  static const Color accentNeon = Color(0xFF00F5D4);
  static const Color textMuted = Color(0xFF393C3C);

  // 3. Central Dark Theme Definition
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: primaryPurple,
        secondary: accentNeon,
        surface: surfaceDark,
      ),
      // Global Text Component Styling
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 2,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
        bodyMedium: TextStyle(fontSize: 14, color: textMuted),
      ),
    );
  }
}
