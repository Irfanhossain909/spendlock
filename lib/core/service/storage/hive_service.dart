import 'package:hive_flutter/hive_flutter.dart';
import 'package:spendlock/core/service/storage/hive_box_names.dart';
import 'package:spendlock/core/utils/app_logger.dart';

class HiveService {
  HiveService._();

  static final HiveService _instance = HiveService._();
  static HiveService get instance => _instance;

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await Hive.initFlutter();
      await Hive.openBox(HiveBoxNames.rules);
      _isInitialized = true;
    } catch (error) {
      AppLogger.error('Hive init failed: $error');
      rethrow;
    }
  }

  Box get rulesBox => Hive.box(HiveBoxNames.rules);
}
