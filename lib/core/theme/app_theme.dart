import 'package:flutter/material.dart';

class AppTheme {
  static const Color _voidBlack = Color(0xFF030303);
  static const Color _surfaceGrey = Color(0xFF121212);
  static const Color _starkWhite = Color(0xFFF5F5F5);
  static const Color _mutedText = Color(0xFF6B6B6B);

  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _voidBlack,
      colorScheme: const ColorScheme.dark(
        primary: _starkWhite,
        surface: _surfaceGrey,
        onSurface: _starkWhite,
      ),

      // Minimalist, sharp App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: _voidBlack,
        foregroundColor: _starkWhite,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 14,
          letterSpacing: 4.0,
          fontWeight: FontWeight.w500,
          color: _mutedText,
        ),
      ),

      // Brutalist input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _voidBlack,
        hintStyle: const TextStyle(color: _mutedText),
        contentPadding: const EdgeInsets.all(24),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero, // Sharp edges
          borderSide: BorderSide(color: _mutedText.withValues(alpha: 0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _mutedText.withValues(alpha: 0.2)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: _starkWhite, width: 1),
        ),
      ),

      // High-contrast, sharp buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _starkWhite,
          foregroundColor: _voidBlack,
          elevation: 0,
          minimumSize: const Size.fromHeight(64),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // Sharp edges
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
    );
  }
}