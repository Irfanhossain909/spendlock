import 'package:flutter/material.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/onboarding/domain/model/onboarding_item_model.dart';

/// Source of onboarding items — swap implementation for API later.
abstract class OnboardingRepository {
  Future<List<OnboardingItemModel>> getItems();
}

class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<List<OnboardingItemModel>> getItems() async {
    return const [
      OnboardingItemModel(
        id: 'lock_spending',
        title: 'Lock impulse spending',
        description:
            'Set smart rules to block unnecessary purchases before they happen. Take back control of your wallet.',
        icon: Icons.lock_outline,
        illustrationBackgroundColor: AppColors.primarySurface,
      ),
      OnboardingItemModel(
        id: 'earn_rewards',
        title: 'Earn Rewards for self control',
        description:
            'Build streaks, collect coins, and redeem them for guilt-free purchases. Make saving feel like a game',
        icon: Icons.emoji_events_outlined,
        illustrationBackgroundColor: AppColors.primarySurface,
      ),
      OnboardingItemModel(
        id: 'savings_grow',
        title: 'Watch your savings grow',
        description:
            'Every purchase you avoid helps your Money Tree flourish into a beautiful garden of savings.',
        icon: Icons.park_outlined,
        illustrationBackgroundColor: AppColors.primarySurface,
      ),
    ];
  }
}
