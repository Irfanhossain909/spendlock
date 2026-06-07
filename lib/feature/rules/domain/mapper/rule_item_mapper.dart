import 'package:flutter/material.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';
import 'package:spendlock/feature/rules/domain/service/rule_engine_service.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_category.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_item.dart';

class RuleItemMapper {
  RuleItemMapper._();

  /// Hive RuleModel → UI RuleItem map করে
  static RuleItem fromModel(RuleModel model) {
    final primaryCategory = _resolvePrimaryCategory(model.categoryIds.firstOrNull);
    final engine = RuleEngineService.instance;

    return RuleItem(
      id: model.id,
      title: model.name,
      time: engine.formatRuleTimeRange(model),
      socialName: 'Lock ${model.packageNames.length} apps',
      duration: _buildDurationLabel(model),
      statusLabel: model.isActive ? 'Active' : 'Inactive',
      icon: primaryCategory?.icon ?? Icons.rule_outlined,
      iconBgColor: primaryCategory?.iconBgColor ?? const Color(0xFFE8F4FF),
      badgeType: model.isTimeBased ? RuleBadgeType.time : RuleBadgeType.limit,
      socialIcons: _buildSocialIcons(model.packageNames.length),
      isActive: model.isActive,
    );
  }

  static RuleCategory? _resolvePrimaryCategory(String? categoryId) {
    if (categoryId == null) return null;
    for (final category in RuleCategories.all) {
      if (category.id == categoryId) return category;
    }
    return null;
  }

  static String _buildDurationLabel(RuleModel model) {
    if (!model.isActive) return 'Inactive';

    if (model.isLimitBased) return 'Limit active';

    if (!RuleEngineService.instance.isRuleActiveNow(model)) {
      return 'Scheduled';
    }

    final remaining = RuleEngineService.instance.getRemainingDuration(model);
    if (remaining == null || remaining <= Duration.zero) {
      return 'Active now';
    }

    final hours = remaining.inHours;
    final minutes = remaining.inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}h left';
  }

  static List<IconData> _buildSocialIcons(int count) {
    const icons = [
      Icons.android,
      Icons.apps,
      Icons.smartphone,
    ];
    if (count <= 0) return [Icons.apps_outlined];
    return List.generate(count.clamp(1, 3), (index) => icons[index % icons.length]);
  }
}

extension _FirstOrNull<E> on List<E> {
  E? get firstOrNull => isEmpty ? null : first;
}
