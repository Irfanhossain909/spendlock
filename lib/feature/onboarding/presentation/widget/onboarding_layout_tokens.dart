import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Figma: mobile frame 430×932. Content column width 357; horizontal inset ≈ 36.5
class OnboardingLayoutTokens {
  OnboardingLayoutTokens._();

  static double get horizontalInset => ((430 - 357) / 2).w;

  static double get illustrationWidth => 357.w;

  /// Frame heights per slide (Figma “Frame 2147231012”).
  static double get illustrationHeightSlide1 => 312.h;
  static double get illustrationHeightSlide2 => 304.h;
  static double get illustrationHeightSlide3 => 358.5.h;

  static double get gapIllustrationToDots => 0;
  static double get gapDotsToTextBlock => 0;
  static double get titleLineHeight => 34 / 24;
  static double get titleFontSize => 24.sp;
  static double get bodyFontSize => 14.sp;
  static double get dotSize => 8.w;
  static double get dotGap => 10.w;
}
