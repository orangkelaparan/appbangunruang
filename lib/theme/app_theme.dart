/// Definisi warna pastel & tema aplikasi "Rumus Bangun Ruang & Datar".
/// Skema warna utama: soft mint, soft lavender, soft peach, soft blue.
library;

import 'package:flutter/material.dart';

/// Skema warna pastel identitas aplikasi.
class AppColors {
  AppColors._();

  // Warna utama identitas visual
  static const Color mint = Color(0xFFB2E0D2); // soft mint
  static const Color mintDark = Color(0xFF6FBF9E);
  static const Color lavender = Color(0xFFD3C7E9); // soft lavender
  static const Color lavenderDark = Color(0xFF9B8AD4);
  static const Color peach = Color(0xFFF7D6C5); // soft peach
  static const Color peachDark = Color(0xFFE8A889);
  static const Color softBlue = Color(0xFFC5D9F2); // soft blue
  static const Color softBlueDark = Color(0xFF7FA6DE);

  // Warna latar & teks
  static const Color background = Color(0xFFFAFAF7);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF3A3F47);
  static const Color textSecondary = Color(0xFF7A818C);
  static const Color errorColor = Color(0xFFE07A6B);
  static const Color surfaceDark = Color(0xFF1E232B);
  static const Color cardColorDark = Color(0xFF2A3039);
  static const Color textPrimaryDark = Color(0xFFECEEF1);
  static const Color textSecondaryDark = Color(0xFFA6ADB8);
}

/// Tema terang (default) aplikasi.
class AppTheme {
  AppTheme._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorSchemeSeed: AppColors.mintDark,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: 'Poppins',
    cardTheme: const CardTheme(
      color: AppColors.cardColor,
      elevation: 2,
      shadowColor: Color(0x223A3F47),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.zero,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      foregroundColor: AppColors.textPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF1F4F2),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      errorStyle: const TextStyle(fontFamily: 'Poppins', color: AppColors.errorColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mintDark,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Poppins', color: AppColors.textPrimary),
      titleLarge: TextStyle(fontFamily: 'Poppins', color: AppColors.textPrimary, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontFamily: 'Poppins', color: AppColors.textPrimary, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontFamily: 'Poppins', color: AppColors.textPrimary),
      bodyMedium: TextStyle(fontFamily: 'Poppins', color: AppColors.textSecondary),
    ),
  );

  /// Tema gelap (opsional, dark mode).
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.mintDark,
    scaffoldBackgroundColor: AppColors.surfaceDark,
    fontFamily: 'Poppins',
    cardTheme: const CardTheme(
      color: AppColors.cardColorDark,
      elevation: 2,
      shadowColor: Color(0x66000000),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      margin: EdgeInsets.zero,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surfaceDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        color: AppColors.textPrimaryDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      foregroundColor: AppColors.textPrimaryDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF333942),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      errorStyle: const TextStyle(fontFamily: 'Poppins', color: AppColors.errorColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mintDark,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontFamily: 'Poppins', color: AppColors.textPrimaryDark),
      titleLarge: TextStyle(fontFamily: 'Poppins', color: AppColors.textPrimaryDark, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontFamily: 'Poppins', color: AppColors.textPrimaryDark, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(fontFamily: 'Poppins', color: AppColors.textPrimaryDark),
      bodyMedium: TextStyle(fontFamily: 'Poppins', color: AppColors.textSecondaryDark),
    ),
  );
}
