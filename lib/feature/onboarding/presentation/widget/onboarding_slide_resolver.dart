import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/feature/onboarding/domain/model/onboarding_item_model.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/slides/onboarding_slide_earn_rewards.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/slides/onboarding_slide_lock_spending.dart';
import 'package:spendlock/feature/onboarding/presentation/widget/slides/onboarding_slide_watch_savings.dart';

/// Maps [OnboardingItemModel.id] to dedicated pixel-tuned slide widgets.
class OnboardingSlideResolver {
  static Widget resolve({
    required OnboardingItemModel item,
    required int totalPages,
    required RxInt activeIndex,
  }) {
    switch (item.id) {
      case 'lock_spending':
        return OnboardingSlideLockSpending(
          item: item,
          totalPages: totalPages,
          activeIndex: activeIndex,
        );
      case 'earn_rewards':
        return OnboardingSlideEarnRewards(
          item: item,
          totalPages: totalPages,
          activeIndex: activeIndex,
        );
      case 'savings_grow':
        return OnboardingSlideWatchSavings(
          item: item,
          totalPages: totalPages,
          activeIndex: activeIndex,
        );
      default:
        return OnboardingSlideLockSpending(
          item: item,
          totalPages: totalPages,
          activeIndex: activeIndex,
        );
    }
  }
}
