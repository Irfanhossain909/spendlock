import 'package:get/get.dart';
import 'package:spendlock/core/const/preference_options.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';

class PreferenceController extends GetxController {
  int selectedGoal = 1;
  List<int> selectedChallenges = [1];
  double monthlyBudget = 2000;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  void _loadFromStorage() {
    final storage = GetStorageServices.instance;
    selectedGoal = storage.getSelectedGoal();
    selectedChallenges = List<int>.from(storage.getSelectedChallenges());
    monthlyBudget = storage.getMonthlyBudget();
    update();
  }

  String get motivationSubtitle =>
      PreferenceOptions.goals[selectedGoal].$2;

  String get triggersSubtitle {
    final titles = selectedChallenges
        .map((i) => PreferenceOptions.triggers[i].$2)
        .toList();
    if (titles.isEmpty) return 'Not set';
    if (titles.length == 1) return titles.first;
    return titles.join(', ');
  }

  String get budgetSubtitle {
    final amount = monthlyBudget.toInt();
    final formatted = amount >= 1000
        ? '\$${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}k'
        : '\$$amount';
    return '$formatted/month';
  }

  void selectGoal(int index) {
    selectedGoal = index;
    update();
  }

  void toggleChallenge(int index) {
    if (selectedChallenges.contains(index)) {
      if (selectedChallenges.length > 1) {
        selectedChallenges.remove(index);
      }
    } else {
      selectedChallenges.add(index);
    }
    update();
  }

  void setBudget(double value) {
    monthlyBudget = value;
    update();
  }

  Future<void> saveMotivation() async {
    await GetStorageServices.instance.setSelectedGoal(selectedGoal);
    update();
    Get.back();
  }

  Future<void> saveTriggers() async {
    await GetStorageServices.instance.setSelectedChallenges(
      List<int>.from(selectedChallenges),
    );
    update();
    Get.back();
  }

  Future<void> saveBudget() async {
    await GetStorageServices.instance.setMonthlyBudget(monthlyBudget);
    update();
    Get.back();
  }
}
