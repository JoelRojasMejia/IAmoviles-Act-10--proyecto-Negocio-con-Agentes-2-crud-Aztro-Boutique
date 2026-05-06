import 'package:flutter/material.dart';

class AppTheme {
  /// 🎨 Colores base
  static const Color primary = Color(0xFF000000); // Negro
  static const Color secondary = Color(0xFFD4AF37); // Dorado elegante
  static const Color background = Color(0xFFF8F8F8); // Blanco suave
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF777777);

  /// 🌟 Tema principal
  static ThemeData get light => ThemeData(
        useMaterial3: true,

        /// Colores globales
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          primary: primary,
          secondary: secondary,
          background: background,
        ),

        scaffoldBackgroundColor: background,

        /// Tipografía
        fontFamily: 'Serif',

        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: textSecondary,
          ),
        ),

        /// AppBar elegante
        appBarTheme: const AppBarTheme(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),

        /// Botones
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),

        /// Inputs elegantes
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: textSecondary),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        /// Floating Button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primary,
          foregroundColor: Colors.white,
        ),

        /// Switch (ofertas)
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(secondary),
          trackColor: MaterialStateProperty.all(secondary.withOpacity(0.4)),
        ),
      );
}