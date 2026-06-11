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

  Future<void> setEmail(String value) async {
    try {
      await box.write(AppStorageKey.instance.email, value);
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  String getEmail() =>
      box.read(AppStorageKey.instance.email) ?? 'sarah@example.com';

  Future<void> setSelectedGoal(int value) async {
    await box.write(AppStorageKey.instance.selectedGoal, value);
  }

  int getSelectedGoal() => box.read(AppStorageKey.instance.selectedGoal) ?? 1;

  Future<void> setSelectedChallenges(List<int> value) async {
    await box.write(AppStorageKey.instance.selectedChallenges, value);
  }

  List<int> getSelectedChallenges() {
    final stored = box.read(AppStorageKey.instance.selectedChallenges);
    if (stored is List) {
      return stored.cast<int>();
    }
    return [1];
  }

  Future<void> setMonthlyBudget(double value) async {
    await box.write(AppStorageKey.instance.monthlyBudget, value);
  }

  double getMonthlyBudget() =>
      (box.read(AppStorageKey.instance.monthlyBudget) ?? 2000).toDouble();

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
    await box.remove(AppStorageKey.instance.name);
    await box.remove(AppStorageKey.instance.email);
    await box.remove(AppStorageKey.instance.selectedGoal);
    await box.remove(AppStorageKey.instance.selectedChallenges);
    await box.remove(AppStorageKey.instance.monthlyBudget);
  }
}
