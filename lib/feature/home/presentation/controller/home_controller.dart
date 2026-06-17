import 'package:get/get.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/profile/presentation/controller/personal_details_controller.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';
import 'package:spendlock/feature/rules/domain/mapper/rule_item_mapper.dart';
import 'package:spendlock/feature/rules/domain/repository/rules_repository.dart';
import 'package:spendlock/feature/rules/presentation/controller/rules_controller.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_item.dart';
import 'package:spendlock/feature/tree/domain/repository/tree_repository.dart';

class HomeController extends GetxController {
  final _treeRepository = TreeRepository.instance;
  final _rulesRepository = RulesRepository.instance;

  final userName = ''.obs;
  final profileImageUrl = RxnString();
  final streakDays = 0.obs;
  final weeklyProgress = 0.obs;
  final totalSavings = 0.0.obs;
  final coins = 0.obs;
  final isLoading = false.obs;
  final activeRules = <RuleItem>[].obs;

  String get displayImageUrl {
    final image = profileImageUrl.value;
    if (image != null && image.isNotEmpty) {
      return image;
    }
    return PersonalDetailsController.defaultAvatarUrl;
  }

  @override
  void onInit() {
    super.onInit();
    loadPersonalDetails();
    refreshData();

    if (Get.isRegistered<ProfileController>()) {
      ever(Get.find<ProfileController>().profile, (_) => loadPersonalDetails());
    }
  }

  Future<void> refreshData() async {
    await Future.wait([loadOverview(), loadActiveRules()]);
  }

  Future<void> loadOverview() async {
    try {
      final response = await _treeRepository.getOverview();
      final data = response?.data;
      if (data == null) return;

      streakDays.value = data.currentStreak ?? 0;
      weeklyProgress.value = (data.currentStreak ?? 0) % 5;
      totalSavings.value = (data.saveBalancePerMonth ?? 0).toDouble();
      coins.value = data.availableCoins ?? 0;
    } catch (error) {
      AppLogger.error('Failed to load home overview: $error');
    }
  }

  Future<void> loadActiveRules() async {
    try {
      isLoading.value = true;
      await _rulesRepository.syncWithBackend();
      final models = _rulesRepository.getActiveRules();
      activeRules.value = models.map(RuleItemMapper.fromModel).toList();
    } catch (error) {
      AppLogger.error('Failed to load active rules: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleRule(String id, bool isActive) async {
    await RulesController.to.toggleRule(id, isActive);
    await loadActiveRules();
  }

  void loadPersonalDetails() {
    if (Get.isRegistered<ProfileController>()) {
      final profileData = Get.find<ProfileController>().profile.value?.data;
      if (profileData != null) {
        userName.value = profileData.name ?? '';
        profileImageUrl.value = profileData.image;
        return;
      }
    }

    userName.value = GetStorageServices.instance.getName();
    profileImageUrl.value = null;
  }
}
