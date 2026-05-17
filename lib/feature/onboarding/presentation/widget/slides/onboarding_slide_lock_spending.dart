import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/onboarding/domain/model/onboarding_item_model.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_copy_block.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_layout_tokens.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_page_dots.dart';

/// Figma: Onboarding — 1 (lock / dollar hero)
class OnboardingSlideLockSpending extends StatelessWidget {
  const OnboardingSlideLockSpending({
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
            height: OnboardingLayoutTokens.illustrationHeightSlide1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 181.w,
                  height: 254.h,
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                Container(
                  width: 123.w,
                  height: 123.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        blurRadius: 40.r,
                        spreadRadius: 20.r,
                      ),
                    ],
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryLight.withValues(alpha: 0.35),
                        AppColors.primary.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.lock_rounded, size: 52.sp, color: AppColors.primary),
                      Positioned(
                        bottom: 22.h,
                        child: Icon(Icons.paid_rounded, size: 28.sp, color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          OnboardingPageDots(count: totalPages, activeIndex: activeIndex),
          const Spacer(flex: 1),
          OnboardingCopyBlock(item: item),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
