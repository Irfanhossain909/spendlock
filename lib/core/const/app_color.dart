import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF0E8279);
  static const Color primaryLight = Color(0xFF2FB8A8);
  static const Color primaryMint = Color(0xFFE6FFFA);
  static const Color primarySurface = Color(0xFFE0F5F2);
  static const Color black = Color(0xFF041C37);
  static const Color gray = Color(0xFF6B7B95);
  static const Color lightGray = Color(0xFFB4BECE);
  static const Color darkGray = Color(0xFF3C4947);
  static const Color stroke = Color(0x1A1B3662);
  static const Color coinGold = Color(0xFFFFB800);
  static const Color coinBg = Color(0x1AFFB800);
  static const Color warningYellow = Color(0xFFFFF4D6);
  static const Color red = Color(0xFFD30000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color redBrown = Color(0xFF841F00);
  static const Color blueAccent = Color(0xFF7265FF);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2FB8A8), Color(0xFF0E8279)],
  );

  static const LinearGradient authBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x03E9F1FF), Color(0xFFFFFFFF)],
    stops: [0.19, 1.0],
  );
}
