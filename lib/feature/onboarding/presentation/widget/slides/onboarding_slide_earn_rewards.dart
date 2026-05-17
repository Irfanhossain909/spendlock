import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/onboarding/domain/model/onboarding_item_model.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_copy_block.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_layout_tokens.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_page_dots.dart';

/// Figma: Onboarding — 2 (medal / rewards)
class OnboardingSlideEarnRewards extends StatelessWidget {
  const OnboardingSlideEarnRewards({
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
          SizedBox(height: 92.h),
          SizedBox(
            width: OnboardingLayoutTokens.illustrationWidth,
            height: OnboardingLayoutTokens.illustrationHeightSlide2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 246.w,
                  height: 246.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primarySurface,
                    border: Border.all(color: AppColors.stroke),
                  ),
                ),
                Icon(item.icon, size: 88.sp, color: AppColors.primary),
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
