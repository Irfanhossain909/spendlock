import 'package:flutter/material.dart';

/// Single onboarding slide — UI reads values only from this model.
class OnboardingItemModel {
  const OnboardingItemModel({
    required this.id,
    required this.title,
    required this.description,
    this.icon,
    this.imageAsset,
    this.illustrationBackgroundColor,
    this.actionLabel,
  }) : assert(
          icon != null || imageAsset != null,
          'Provide either icon or imageAsset',
        );

  final String id;
  final String title;
  final String description;
  final IconData? icon;
  final String? imageAsset;
  final Color? illustrationBackgroundColor;

  /// When null, parent uses default (Continue / Get Started).
  final String? actionLabel;

  OnboardingItemModel copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    String? imageAsset,
    Color? illustrationBackgroundColor,
    String? actionLabel,
  }) {
    return OnboardingItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      imageAsset: imageAsset ?? this.imageAsset,
      illustrationBackgroundColor:
          illustrationBackgroundColor ?? this.illustrationBackgroundColor,
      actionLabel: actionLabel ?? this.actionLabel,
    );
  }
}
