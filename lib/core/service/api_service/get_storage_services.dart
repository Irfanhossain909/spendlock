import 'package:get_storage/get_storage.dart';
import 'package:spendlock/core/service/api_service/app_storage_key.dart';
import 'package:spendlock/core/utils/app_logger.dart';

class GetStorageServices {
  GetStorageServices._privateConstructor();
  static final GetStorageServices _instance =
      GetStorageServices._privateConstructor();
  static GetStorageServices get instance => _instance;

  final GetStorage box = GetStorage();

  Future<void> setToken(String value) async {
    try {
      await box.write(AppStorageKey.instance.token, value);
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  String getToken() => box.read(AppStorageKey.instance.token) ?? '';

  Future<void> setIsGuest(bool value) async {
    try {
      await box.write(AppStorageKey.instance.isGuest, value);
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  bool getIsGuest() => box.read(AppStorageKey.instance.isGuest) ?? false;

  Future<void> setName(String value) async {
    try {
      await box.write(AppStorageKey.instance.name, value);
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  String getName() => box.read(AppStorageKey.instance.name) ?? 'Sarah Leo';

  Future<void> setOnboardingDone(bool value) async {
    await box.write(AppStorageKey.instance.onboardingDone, value);
  }

  bool getOnboardingDone() =>
      box.read(AppStorageKey.instance.onboardingDone) ?? false;

  Future<void> setSetupDone(bool value) async {
    await box.write(AppStorageKey.instance.setupDone, value);
  }

  bool getSetupDone() => box.read(AppStorageKey.instance.setupDone) ?? false;

  Future<void> clearSession() async {
    await box.remove(AppStorageKey.instance.token);
    await box.remove(AppStorageKey.instance.isGuest);
    await box.remove(AppStorageKey.instance.setupDone);
  }
}
