import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spendlock/core/const/app_color.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final base = GoogleFonts.plusJakartaSansTextTheme();
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        surface: AppColors.background,
        onSurface: AppColors.black,
      ),
      textTheme: base.apply(
        bodyColor: AppColors.black,
        displayColor: AppColors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.black),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        hintStyle: GoogleFonts.inter(
          color: AppColors.lightGray,
          fontSize: 14,
        ),
      ),
    );
  }
}
