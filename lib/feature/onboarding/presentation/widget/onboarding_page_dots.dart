import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/onboarding_layout_tokens.dart';

/// Dots below illustration — listens to [activeIndex] once per screen tree.
class OnboardingPageDots extends StatelessWidget {
  const OnboardingPageDots({
    super.key,
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final RxInt activeIndex;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          final active = activeIndex.value == i;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: OnboardingLayoutTokens.dotGap / 2),
            child: Container(
              width: OnboardingLayoutTokens.dotSize,
              height: OnboardingLayoutTokens.dotSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? AppColors.primary : AppColors.lightGray.withValues(alpha: 0.45),
              ),
            ),
          );
        }),
      ),
    );
  }
}
