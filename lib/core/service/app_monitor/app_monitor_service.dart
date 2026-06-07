import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/rules/domain/model/rule_model.dart';
import 'package:spendlock/feature/rules/domain/repository/rules_repository.dart';
import 'package:spendlock/feature/rules/domain/service/rule_engine_service.dart';

class AppMonitorService extends GetxService with WidgetsBindingObserver {
  AppMonitorService._();

  static AppMonitorService? _instance;
  static AppMonitorService get instance {
    _instance ??= Get.put(AppMonitorService._(), permanent: true);
    return _instance!;
  }

  static const _methodChannel = MethodChannel('com.spendlock/app_monitor');
  static const _eventChannel = EventChannel('com.spendlock/app_guard_events');

  StreamSubscription<dynamic>? _guardEventSub;
  bool _isLockOverlayVisible = false;
  bool _isHandlerReady = false;
  bool _hasBootstrapped = false;

  final _engine = RuleEngineService.instance;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _startGuardEventListener();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(bootstrap());
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(bootstrap());
    }
  }

  /// App start/resume এ guard service + overlay setup
  Future<void> bootstrap() async {
    if (_hasBootstrapped) {
      await startMonitoring();
      return;
    }

    _methodChannel.setMethodCallHandler(_handleNativeCallback);
    _isHandlerReady = true;
    _hasBootstrapped = true;

    await _handleColdStartLock();
    await startMonitoring();

    if (Platform.isAndroid) {
      await _ensureBatteryOptimization();
      await _ensureOverlayPermission();
    }
  }

  /// EventChannel দিয়ে native blocked-app events listen করে
  void _startGuardEventListener() {
    if (!Platform.isAndroid) return;

    _guardEventSub?.cancel();
    _guardEventSub = _eventChannel.receiveBroadcastStream().listen(
      (event) {
        final packageName = event?.toString();
        if (packageName == null || packageName.isEmpty) return;
        unawaited(_markLockOverlayVisible());
      },
      onError: (Object error) {
        AppLogger.error('Guard event stream error: $error');
      },
    );
  }

  /// Cold start এ pending lock overlay show করে
  Future<void> _handleColdStartLock() async {
    try {
      final packageName =
          await _methodChannel.invokeMethod<String>('getLaunchLockPackage');
      if (packageName == null || packageName.isEmpty) return;

      final rule = _engine.findBlockingRule(packageName);
      if (rule == null) return;

      await _showNativeLockOverlay(rule, packageName);
    } catch (error) {
      AppLogger.error('Cold start lock failed: $error');
    }
  }

  /// Native guard service + overlay payload sync করে
  Future<void> startMonitoring() async {
    if (!_isHandlerReady) {
      _methodChannel.setMethodCallHandler(_handleNativeCallback);
      _isHandlerReady = true;
    }

    if (Platform.isAndroid) {
      final hasPermission = await hasUsagePermission();
      if (!hasPermission) {
        AppLogger.error('Usage access permission not granted');
        return;
      }
    }

    await _syncLockConfigToNative();

    if (Platform.isAndroid) {
      await _methodChannel.invokeMethod('flushPendingLock');
    }
  }

  /// Native guard service stop করে
  Future<void> stopMonitoring() async {
    try {
      await _methodChannel.invokeMethod('stopGuardService');
    } catch (error) {
      AppLogger.error('Stop guard service failed: $error');
    }
  }

  /// Overlay dismiss + guard state reset করে
  Future<void> resetGuardState() async {
    _isLockOverlayVisible = false;
    try {
      await _methodChannel.invokeMethod('hideLockOverlay');
      await _methodChannel.invokeMethod('resetGuardState');
    } catch (error) {
      AppLogger.error('Reset guard state failed: $error');
    }
  }

  /// Usage access permission আছে কিনা check করে (Android)
  Future<bool> hasUsagePermission() async {
    if (!Platform.isAndroid) return false;
    try {
      final result = await _methodChannel.invokeMethod<bool>('hasUsagePermission');
      return result ?? false;
    } catch (error) {
      AppLogger.error('Usage permission check failed: $error');
      return false;
    }
  }

  /// Overlay permission আছে কিনা check করে (Android)
  Future<bool> hasOverlayPermission() async {
    if (!Platform.isAndroid) return true;
    try {
      final result =
          await _methodChannel.invokeMethod<bool>('hasOverlayPermission');
      return result ?? false;
    } catch (error) {
      AppLogger.error('Overlay permission check failed: $error');
      return false;
    }
  }

  /// Usage access settings screen open করে
  Future<void> openUsageSettings() async {
    if (!Platform.isAndroid) return;
    try {
      await _methodChannel.invokeMethod('openUsageSettings');
    } catch (error) {
      AppLogger.error('Open usage settings failed: $error');
    }
  }

  /// Overlay settings screen open করে
  Future<void> openOverlaySettings() async {
    if (!Platform.isAndroid) return;
    try {
      await _methodChannel.invokeMethod('openOverlaySettings');
    } catch (error) {
      AppLogger.error('Open overlay settings failed: $error');
    }
  }

  /// Usage permission না থাকলে settings open করে
  Future<void> ensureUsagePermission({bool showMessage = true}) async {
    if (!Platform.isAndroid) return;

    final hasPermission = await hasUsagePermission();
    if (hasPermission) {
      await bootstrap();
      return;
    }

    if (showMessage) {
      AppSnackBar.message(
        'Allow usage access so SpendLock can detect locked apps',
      );
    }
    await openUsageSettings();
  }

  /// Overlay permission না থাকলে settings open করে
  Future<void> _ensureOverlayPermission() async {
    final hasPermission = await hasOverlayPermission();
    if (hasPermission) return;

    AppSnackBar.message(
      'Allow display over other apps so SpendLock lock overlay can appear',
    );
    await openOverlaySettings();
  }

  /// Battery optimization disable request করে (Realme/Oppo etc.)
  Future<void> _ensureBatteryOptimization() async {
    if (!Platform.isAndroid) return;

    try {
      final ignored =
          await _methodChannel.invokeMethod<bool>('isBatteryOptimizationIgnored');
      if (ignored == true) return;

      AppSnackBar.message(
        'Disable battery optimization for SpendLock to work in background',
      );
      await _methodChannel.invokeMethod('openBatterySettings');
    } catch (error) {
      AppLogger.error('Battery optimization check failed: $error');
    }
  }

  /// Lock overlay visible flag set করে
  void setLockScreenVisible(bool value) {
    _isLockOverlayVisible = value;
  }

  /// Active rules native service + overlay payloads এ sync করে
  Future<void> _syncLockConfigToNative() async {
    try {
      final activeRules = RulesRepository.instance.getActiveRules();
      final blockedPackages = <String>{};
      final payloads = <String, Map<String, dynamic>>{};

      for (final rule in activeRules) {
        final payload = _buildLockPayload(rule);
        for (final packageName in rule.packageNames) {
          blockedPackages.add(packageName);
          payloads[packageName] = payload;
        }
      }

      await _methodChannel.invokeMethod('syncLockPayloads', {
        'payloads': payloads,
      });

      if (blockedPackages.isEmpty) {
        await stopMonitoring();
        return;
      }

      if (Platform.isAndroid) {
        await _methodChannel.invokeMethod('startGuardService', {
          'blockedPackages': blockedPackages.toList(),
        });
      }
    } catch (error) {
      AppLogger.error('Sync lock config failed: $error');
    }
  }

  /// Rule থেকে native overlay payload build করে
  Map<String, dynamic> _buildLockPayload(RuleModel rule) {
    final remaining = _engine.getRemainingDuration(rule);
    return {
      'ruleMessage': _engine.formatRuleMessage(rule),
      'isLimitBased': rule.isLimitBased,
      'remainingSeconds': remaining?.inSeconds ?? 0,
    };
  }

  /// Native MethodChannel callback handle করে
  Future<void> _handleNativeCallback(MethodCall call) async {
    switch (call.method) {
      case 'onBlockedAppOpened':
        final packageName = call.arguments as String?;
        if (packageName == null || packageName.isEmpty) return;
        await _handleBlockedPackage(packageName);
      case 'onLockOverlayDismissed':
        _isLockOverlayVisible = false;
        setLockScreenVisible(false);
    }
  }

  /// Blocked package detect হলে native overlay show করে
  Future<void> _handleBlockedPackage(
    String packageName, {
    bool force = false,
  }) async {
    if (!force && (!_isHandlerReady || _isLockOverlayVisible)) return;

    final blockingRule = _engine.findBlockingRule(packageName);
    if (blockingRule == null) return;

    await _showNativeLockOverlay(blockingRule, packageName);
  }

  /// Native overlay show করে (Android/iOS আলাদা implementation)
  Future<void> _showNativeLockOverlay(
    RuleModel rule,
    String packageName,
  ) async {
    if (_isLockOverlayVisible) return;

    try {
      final isShowing =
          await _methodChannel.invokeMethod<bool>('isLockOverlayShowing');
      if (isShowing == true) {
        _isLockOverlayVisible = true;
        setLockScreenVisible(true);
        return;
      }
    } catch (_) {}

    _isLockOverlayVisible = true;
    setLockScreenVisible(true);

    try {
      await _methodChannel.invokeMethod('showLockOverlay', {
        'blockedPackage': packageName,
        ..._buildLockPayload(rule),
      });
    } catch (error) {
      _isLockOverlayVisible = false;
      setLockScreenVisible(false);
      AppLogger.error('Show native lock overlay failed: $error');
    }
  }

  Future<void> _markLockOverlayVisible() async {
    _isLockOverlayVisible = true;
    setLockScreenVisible(true);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _guardEventSub?.cancel();
    stopMonitoring();
    super.onClose();
  }
}
