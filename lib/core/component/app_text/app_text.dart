import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spendlock/core/const/app_color.dart';

class AppText extends StatelessWidget {
  const AppText({
    super.key,
    required this.data,
    this.fontSize = 16,
    this.color,
    this.fontWeight,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign,
    this.height,
    this.letterSpacing,
    this.fontFamily,
  });

  final String data;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final double? letterSpacing;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    TextStyle style;
    switch (fontFamily) {
      case 'inter':
        style = GoogleFonts.inter(
          fontSize: fontSize,
          color: color ?? AppColors.black,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
        );
        break;
      case 'hanken':
        style = GoogleFonts.hankenGrotesk(
          fontSize: fontSize,
          color: color ?? AppColors.black,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
        );
        break;
      default:
        style = GoogleFonts.plusJakartaSans(
          fontSize: fontSize,
          color: color ?? AppColors.black,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
        );
    }
    return Text(
      data,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: style,
    );
  }
}
