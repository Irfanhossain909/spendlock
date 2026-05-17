import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/onboarding/domain/model/onboarding_item_model.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_copy_block.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_layout_tokens.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_page_dots.dart';

/// Figma: Onboarding — 3 (money tree)
class OnboardingSlideWatchSavings extends StatelessWidget {
  const OnboardingSlideWatchSavings({
    super.key,
    required this.item,
    required this.totalPages,
    required this.activeIndex,
  });

  final OnboardingItemModel item;
  final int totalPages;
  final RxInt activeIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: OnboardingLayoutTokens.horizontalInset),
      child: Column(
        children: [
          SizedBox(height: 64.h),
          SizedBox(
            width: OnboardingLayoutTokens.illustrationWidth,
            height: OnboardingLayoutTokens.illustrationHeightSlide3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Icon(item.icon, size: 120.sp, color: AppColors.primary),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          OnboardingPageDots(count: totalPages, activeIndex: activeIndex),
          const Spacer(flex: 1),
          OnboardingCopyBlock(item: item),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
