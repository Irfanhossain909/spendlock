import 'package:get/get.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/feature/rules/presentation/model/selectable_app_item.dart';

class SelectRuleAppsController extends GetxController {
  final searchQuery = ''.obs;
  final selectedAppIds = <String>[].obs;

  final List<SelectableAppItem> allApps = SelectableAppsCatalog.defaults;

  List<SelectableAppItem> get filteredApps {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return allApps;
    return allApps
        .where(
          (app) =>
              app.name.toLowerCase().contains(q) ||
              app.category.toLowerCase().contains(q),
        )
        .toList();
  }

  bool get hasSelection => selectedAppIds.isNotEmpty;

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void toggleApp(String id) {
    if (selectedAppIds.contains(id)) {
      selectedAppIds.remove(id);
    } else {
      selectedAppIds.add(id);
    }
  }

  bool isSelected(String id) => selectedAppIds.contains(id);

  void confirm() {
    if (!hasSelection) return;
    Get.until(
      (route) => route.settings.name == AppRoutes.instance.navigationScreen,
    );
  }
}
