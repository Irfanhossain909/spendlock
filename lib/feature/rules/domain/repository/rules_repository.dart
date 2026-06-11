import 'package:spendlock/core/service/storage/hive_service.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';

class RulesRepository {
  RulesRepository._();

  static final RulesRepository _instance = RulesRepository._();
  static RulesRepository get instance => _instance;

  /// Hive box থেকে সব rules load করে
  List<RuleModel> getAllRules() {
    if (!HiveService.instance.isInitialized) {
      AppLogger.error('Hive is not initialized');
      return const [];
    }

    try {
      final box = HiveService.instance.rulesBox;
      final rules = <RuleModel>[];

      for (final key in box.keys) {
        final raw = box.get(key);
        final model = _parseRule(raw);
        if (model != null) rules.add(model);
      }

      rules.sort((a, b) => b.createdAtMillis.compareTo(a.createdAtMillis));
      return rules;
    } catch (error) {
      AppLogger.error('Failed to load rules: $error');
      return const [];
    }
  }

  /// Active rules only return করে
  List<RuleModel> getActiveRules() {
    return getAllRules().where((rule) => rule.isActive).toList();
  }

  /// ID দিয়ে single rule খুঁজে
  RuleModel? getRuleById(String id) {
    try {
      return _parseRule(HiveService.instance.rulesBox.get(id));
    } catch (error) {
      AppLogger.error('Failed to get rule: $error');
      return null;
    }
  }

  /// নতুন rule save/update করে
  Future<void> saveRule(RuleModel rule) async {
    try {
      await HiveService.instance.rulesBox.put(rule.id, rule.toJson());
    } catch (error) {
      AppLogger.error('Failed to save rule: $error');
      rethrow;
    }
  }

  /// Rule active/pause toggle করে
  Future<void> updateRuleActive(String id, bool isActive) async {
    final rule = getRuleById(id);
    if (rule == null) return;
    await saveRule(rule.copyWith(isActive: isActive));
  }

  /// Rule delete করে
  Future<void> deleteRule(String id) async {
    try {
      await HiveService.instance.rulesBox.delete(id);
    } catch (error) {
      AppLogger.error('Failed to delete rule: $error');
      rethrow;
    }
  }

  /// Logout এর সময় সব locally saved rules clear করে
  Future<void> clearAllRules() async {
    if (!HiveService.instance.isInitialized) return;

    try {
      await HiveService.instance.rulesBox.clear();
    } catch (error) {
      AppLogger.error('Failed to clear rules: $error');
      rethrow;
    }
  }

  RuleModel? _parseRule(dynamic raw) {
    if (raw is Map) {
      return RuleModel.fromJson(Map<String, dynamic>.from(raw));
    }
    return null;
  }
}
