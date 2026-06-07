import 'dart:async';

import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/app_monitor/app_monitor_service.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';
import 'package:spendlock/feature/rules/domain/service/rule_engine_service.dart';

class LockScreenController extends GetxController {
  late final RuleModel rule;

  final remainingText = '--:--:--'.obs;
  final ruleMessage = ''.obs;

  Timer? _timer;
  final _engine = RuleEngineService.instance;

  @override
  void onInit() {
    super.onInit();
    _readArguments();
    _startCountdown();
    AppMonitorService.instance.setLockScreenVisible(true);
  }

  /// Navigation arguments থেকে blocking rule read করে
  void _readArguments() {
    final args = Get.arguments;
    if (args is RuleModel) {
      rule = args;
    } else {
      rule = RuleModel(
        id: 'fallback',
        type: 0,
        name: 'SpendLock Rule',
        categoryIds: const [],
        timeFromMinutes: 0,
        timeToMinutes: 0,
        activeDayIndices: const [],
        packageNames: const [],
        createdAtMillis: DateTime.now().millisecondsSinceEpoch,
      );
    }

    ruleMessage.value = _engine.formatRuleMessage(rule);
    _updateRemainingText();
  }

  /// Remaining time countdown timer start করে
  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateRemainingText();
    });
  }

  /// Remaining time text update করে
  void _updateRemainingText() {
    if (rule.isLimitBased) {
      remainingText.value = 'Limit Active';
      return;
    }

    final remaining = _engine.getRemainingDuration(rule);
    if (remaining == null || remaining <= Duration.zero) {
      remainingText.value = '00:00:00';
      return;
    }

    final hours = remaining.inHours;
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);
    remainingText.value =
        '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  /// Lock overlay close করে guard state reset করে
  Future<void> closeLockScreen() async {
    await AppMonitorService.instance.resetGuardState();
    AppMonitorService.instance.setLockScreenVisible(false);
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back();
      return;
    }
    Get.offAllNamed(AppRoutes.instance.navigationScreen);
  }

  @override
  void onClose() {
    _timer?.cancel();
    AppMonitorService.instance.setLockScreenVisible(false);
    unawaited(AppMonitorService.instance.resetGuardState());
    super.onClose();
  }
}
