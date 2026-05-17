import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/onboarding/domain/model/onboarding_item_model.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_layout_tokens.dart';

/// Title + body — matches Figma Plus Jakarta / gray body (#6B7B95).
class OnboardingCopyBlock extends StatelessWidget {
  const OnboardingCopyBlock({super.key, required this.item});

  final OnboardingItemModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          item.title,
          textAlign: TextAlign.center,
          maxLines: 3,
          style: GoogleFonts.plusJakartaSans(
            fontSize: OnboardingLayoutTokens.titleFontSize,
            fontWeight: FontWeight.w700,
            height: OnboardingLayoutTokens.titleLineHeight,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          item.description,
          textAlign: TextAlign.center,
          maxLines: 5,
          style: GoogleFonts.plusJakartaSans(
            fontSize: OnboardingLayoutTokens.bodyFontSize,
            fontWeight: FontWeight.w500,
            height: 18 / 14,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }
}
