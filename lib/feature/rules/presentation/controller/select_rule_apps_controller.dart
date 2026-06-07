import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/app_monitor/app_monitor_service.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/navigation/presentation/controller/navigation_controller.dart';
import 'package:spendlock/feature/rules/domain/model/installed_app_model.dart';
import 'package:spendlock/feature/rules/domain/repository/installed_apps_repository.dart';
import 'package:spendlock/feature/rules/domain/repository/rules_repository.dart';
import 'package:spendlock/feature/rules/domain/utils/installed_app_category_mapper.dart';
import 'package:spendlock/feature/rules/presentation/controller/create_rule_session_controller.dart';
import 'package:spendlock/feature/rules/presentation/controller/rules_controller.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_item.dart';
import 'package:spendlock/feature/rules/presentation/model/selectable_app_item.dart';

class SelectRuleAppsController extends GetxController {
  final InstalledAppsRepository _repository = InstalledAppsRepository.instance;
  final RulesRepository _rulesRepository = RulesRepository.instance;

  final searchQuery = ''.obs;
  final selectedAppIds = <String>[].obs;
  final allApps = <SelectableAppItem>[].obs;
  final isLoading = false.obs;
  final isSaving = false.obs;

  late final CreateRuleSessionController _session;

  Set<String> _selectedCategoryIds = {};

  bool get hasSelection => selectedAppIds.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    _session = Get.find<CreateRuleSessionController>();
    _readNavigationArguments();
    loadInstalledApps();
  }

  /// Session থেকে selected category ids read করে
  void _readNavigationArguments() {
    _selectedCategoryIds = _session.categoryIds.toSet();
  }

  /// Device থেকে installed apps load করে category filter apply করে
  Future<void> loadInstalledApps() async {
    try {
      isLoading.value = true;

      final installedApps = await _repository.fetchInstalledApps();
      final mappedApps = _mapToSelectableApps(installedApps);
      allApps.value = _filterBySelectedCategories(mappedApps);
    } catch (_) {
      allApps.clear();
      AppSnackBar.error('Could not load installed apps');
    } finally {
      isLoading.value = false;
    }
  }

  /// InstalledAppModel → SelectableAppItem convert করে
  List<SelectableAppItem> _mapToSelectableApps(
    List<InstalledAppModel> apps,
  ) {
    return apps
        .map(
          (app) => SelectableAppItem.fromInstalledApp(
            packageName: app.packageName,
            name: app.name,
            category: app.categoryLabel,
            iconBytes: app.iconBytes,
          ),
        )
        .toList();
  }

  /// Selected rule categories অনুযায়ী installed apps filter করে
  List<SelectableAppItem> _filterBySelectedCategories(
    List<SelectableAppItem> apps,
  ) {
    final filterCategories = InstalledAppCategoryMapper.resolveFilterCategories(
      _selectedCategoryIds,
    );

    if (filterCategories.isEmpty) return apps;

    final allowedLabels = filterCategories
        .map(InstalledAppCategoryMapper.categoryLabel)
        .toSet();

    return apps
        .where((app) => allowedLabels.contains(app.category))
        .toList();
  }

  /// Search query update করে
  void updateSearch(String value) {
    searchQuery.value = value;
  }

  /// Search query + loaded apps combine করে filtered list return করে
  List<SelectableAppItem> get filteredApps {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return allApps;

    return allApps
        .where(
          (app) =>
              app.name.toLowerCase().contains(query) ||
              app.category.toLowerCase().contains(query) ||
              app.id.toLowerCase().contains(query),
        )
        .toList();
  }

  /// Tap করলে app select/deselect toggle করে
  void toggleApp(String id) {
    if (selectedAppIds.contains(id)) {
      selectedAppIds.remove(id);
    } else {
      selectedAppIds.add(id);
    }
  }

  /// Specific app selected কিনা check করে
  bool isSelected(String id) => selectedAppIds.contains(id);

  /// Selected apps confirm করে Hive-এ rule save করে
  Future<void> confirm() async {
    if (!hasSelection || isSaving.value) return;

    try {
      isSaving.value = true;

      _session.setSelectedPackageNames(selectedAppIds.toList());
      final rule = _session.buildRuleModel();
      await _rulesRepository.saveRule(rule);

      final saved = _rulesRepository.getRuleById(rule.id);
      if (saved == null) {
        throw StateError('Rule was not saved to Hive');
      }

      _session.reset();
      AppSnackBar.success('Rule added successfully');

      Get.until(
        (route) => route.settings.name == AppRoutes.instance.navigationScreen,
      );

      RulesController.to.selectedFilter.value = RulesFilter.all;

      if (Get.isRegistered<NavigationController>()) {
        Get.find<NavigationController>().changeIndex(1);
      }

      await RulesController.refreshList();

      await AppMonitorService.instance.startMonitoring();
      await AppMonitorService.instance.ensureUsagePermission();
    } catch (error) {
      AppSnackBar.error('Could not save rule');
    } finally {
      isSaving.value = false;
    }
  }
}
