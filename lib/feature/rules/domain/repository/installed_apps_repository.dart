import 'dart:io';

import 'package:installed_apps/installed_apps.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/rules/domain/model/installed_app_model.dart';

class InstalledAppsRepository {
  InstalledAppsRepository._();

  static final InstalledAppsRepository _instance = InstalledAppsRepository._();
  static InstalledAppsRepository get instance => _instance;

  /// Device থেকে launchable installed apps list fetch করে
  Future<List<InstalledAppModel>> fetchInstalledApps() async {
    if (!Platform.isAndroid) {
      return const [];
    }

    try {
      final apps = await InstalledApps.getInstalledApps(
        excludeSystemApps: true,
        excludeNonLaunchableApps: true,
        withIcon: true,
      );

      return apps
          .map(InstalledAppModel.fromAppInfo)
          .toList()
        ..sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
    } catch (error, stackTrace) {
      AppLogger.error('Failed to load installed apps: $error');
      AppLogger.error(stackTrace.toString());
      return const [];
    }
  }

  /// Single app info fetch করে (future use)
  Future<InstalledAppModel?> fetchAppInfo(String packageName) async {
    if (!Platform.isAndroid) return null;

    try {
      final info = await InstalledApps.getAppInfo(packageName);
      if (info == null) return null;
      return InstalledAppModel.fromAppInfo(info);
    } catch (error) {
      AppLogger.error('Failed to load app info: $error');
      return null;
    }
  }
}
