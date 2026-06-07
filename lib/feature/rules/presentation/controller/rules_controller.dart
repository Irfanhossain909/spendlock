import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/service/app_monitor/app_monitor_service.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/rules/domain/mapper/rule_item_mapper.dart';
import 'package:spendlock/feature/rules/domain/repository/rules_repository.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_item.dart';

class RulesController extends GetxController {
  RulesController._();

  static RulesController? _instance;

  /// Singleton RulesController — list screen সবসময় same instance use করবে
  static RulesController get to {
    if (_instance != null && Get.isRegistered<RulesController>()) {
      return _instance!;
    }
    if (Get.isRegistered<RulesController>()) {
      _instance = Get.find<RulesController>();
      return _instance!;
    }
    _instance = Get.put(RulesController._(), permanent: true);
    return _instance!;
  }

  /// Hive থেকে rules reload করে list screen update করে
  static Future<void> refreshList() => to.loadRules();

  final _repository = RulesRepository.instance;

  final selectedFilter = RulesFilter.all.obs;
  final rules = <RuleItem>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRules();
    AppMonitorService.instance.startMonitoring();
  }

  /// Hive থেকে rules load করে UI list update করে
  Future<void> loadRules() async {
    try {
      isLoading.value = true;
      final models = _repository.getAllRules();
      final items = models.map(RuleItemMapper.fromModel).toList();
      rules.value = items;
    } catch (error, stackTrace) {
      AppLogger.error('loadRules failed: $error');
      AppLogger.error(stackTrace.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Filter অনুযায়ী rules list return করে
  List<RuleItem> filteredRulesFor(RulesFilter filter) {
    switch (filter) {
      case RulesFilter.all:
        return List<RuleItem>.from(rules);
      case RulesFilter.active:
        return rules.where((rule) => rule.isActive).toList();
      case RulesFilter.paused:
        return rules.where((rule) => !rule.isActive).toList();
    }
  }

  int get activeCount => rules.where((rule) => rule.isActive).length;

  /// Filter tab change করে
  void changeFilter(RulesFilter filter) {
    selectedFilter.value = filter;
  }

  /// Rule active/pause toggle করে Hive-এ save করে
  Future<void> toggleRule(String id, bool isActive) async {
    await _repository.updateRuleActive(id, isActive);
    await loadRules();
    await AppMonitorService.instance.startMonitoring();
    AppSnackBar.success(isActive ? 'Rule activated' : 'Rule deactivated');
  }

  /// Rule delete করে confirmation dialog সহ
  Future<void> deleteRule(String id) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete rule?'),
        content: const Text('This rule will be permanently removed.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _repository.deleteRule(id);
    await loadRules();
    await AppMonitorService.instance.startMonitoring();
    AppSnackBar.success('Rule deleted');
  }
}
