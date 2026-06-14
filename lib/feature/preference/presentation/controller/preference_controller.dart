import 'package:get/get.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/preference/domain/model/motivation_list_model.dart';
import 'package:spendlock/feature/preference/domain/model/triger_list_model.dart';
import 'package:spendlock/feature/preference/domain/repository/preference_repository.dart';
import 'package:spendlock/feature/profile/domain/repository/profile_repository.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';

class PreferenceController extends GetxController {
  final PreferenceRepository preferenceRepository = PreferenceRepository.instance;
  final ProfileRepository profileRepository = ProfileRepository.instance;

  List<MotivationListDataModel> motivationList = [];
  List<Datum> triggerList = [];

  String? selectedMotivationId;
  String? selectedTriggerId;
  double monthlyBudget = 2000;

  bool isLoadingMotivation = false;
  bool isLoadingTrigger = false;
  bool isSaving = false;

  static const int _listLimit = 50;

  @override
  void onInit() {
    super.onInit();
    _loadFromProfile();
    fetchMotivationList();
    fetchTriggerList();
  }

  void _loadFromProfile() {
    if (!Get.isRegistered<ProfileController>()) return;

    final preference =
        Get.find<ProfileController>().profile.value?.data?.preference;
    if (preference == null) return;

    if (preference.motivation != null && preference.motivation!.isNotEmpty) {
      selectedMotivationId = preference.motivation;
    }

    if (preference.trigger != null && preference.trigger!.isNotEmpty) {
      selectedTriggerId = preference.trigger;
    }

    if (preference.budget != null) {
      monthlyBudget = preference.budget!.toDouble();
    }
  }

  void _applyMotivationSelection() {
    if (selectedMotivationId != null) return;

    for (final item in motivationList) {
      if (item.preference == true && item.id != null) {
        selectedMotivationId = item.id;
        return;
      }
    }
  }

  void _applyTriggerSelection() {
    if (selectedTriggerId != null) return;

    for (final item in triggerList) {
      if (item.preference == true && item.id != null) {
        selectedTriggerId = item.id;
        return;
      }
    }
  }

  Future<void> fetchMotivationList() async {
    isLoadingMotivation = true;
    update();

    final response = await preferenceRepository.getMotivationList(
      page: 1,
      limit: _listLimit,
    );

    motivationList = response?.data ?? [];
    _loadFromProfile();
    _applyMotivationSelection();

    isLoadingMotivation = false;
    update();
  }

  Future<void> fetchTriggerList() async {
    isLoadingTrigger = true;
    update();

    final response = await preferenceRepository.getTriggerList(
      page: 1,
      limit: _listLimit,
    );

    triggerList = response?.data ?? [];
    _loadFromProfile();
    _applyTriggerSelection();

    isLoadingTrigger = false;
    update();
  }

  String get motivationSubtitle {
    if (selectedMotivationId == null) return 'Not set';

    for (final item in motivationList) {
      if (item.id == selectedMotivationId) {
        return item.title ?? 'Not set';
      }
    }
    return 'Not set';
  }

  String get triggersSubtitle {
    if (selectedTriggerId == null) return 'Not set';

    for (final item in triggerList) {
      if (item.id == selectedTriggerId) {
        return item.title ?? 'Not set';
      }
    }
    return 'Not set';
  }

  String get budgetSubtitle {
    final amount = monthlyBudget.toInt();
    final formatted = amount >= 1000
        ? '\$${(amount / 1000).toStringAsFixed(amount % 1000 == 0 ? 0 : 1)}k'
        : '\$$amount';
    return '$formatted/month';
  }

  void selectMotivation(String id) {
    selectedMotivationId = id;
    update();
  }

  void selectTrigger(String id) {
    selectedTriggerId = id;
    update();
  }

  void setBudget(double value) {
    monthlyBudget = value;
    update();
  }

  Future<void> _refreshProfile() async {
    if (Get.isRegistered<ProfileController>()) {
      await Get.find<ProfileController>().getProfile();
      _loadFromProfile();
      update();
    }
  }

  Future<void> saveMotivation() async {
    final motivationId = selectedMotivationId;
    if (motivationId == null || motivationId.isEmpty) {
      AppSnackBar.error('Please select a motivation.');
      return;
    }

    isSaving = true;
    update();

    final success = await profileRepository.updateUserProfile(
      motivation: motivationId,
    );

    isSaving = false;

    if (!success) {
      update();
      AppSnackBar.error('Failed to save motivation. Please try again.');
      return;
    }

    await _refreshProfile();
    update();
    Get.back();
    AppSnackBar.success('Motivation saved.');
  }

  Future<void> saveTriggers() async {
    final triggerId = selectedTriggerId;
    if (triggerId == null || triggerId.isEmpty) {
      AppSnackBar.error('Please select a trigger.');
      return;
    }

    isSaving = true;
    update();

    final success = await profileRepository.updateUserProfile(
      trigger: triggerId,
    );

    isSaving = false;

    if (!success) {
      update();
      AppSnackBar.error('Failed to save triggers. Please try again.');
      return;
    }

    await _refreshProfile();
    update();
    Get.back();
    AppSnackBar.success('Triggers saved.');
  }

  Future<void> saveBudget() async {
    isSaving = true;
    update();

    final success = await profileRepository.updateUserProfile(
      budget: monthlyBudget.toInt(),
    );

    isSaving = false;

    if (!success) {
      update();
      AppSnackBar.error('Failed to save budget. Please try again.');
      return;
    }

    await _refreshProfile();
    update();
    Get.back();
    AppSnackBar.success('Budget saved.');
  }
}
