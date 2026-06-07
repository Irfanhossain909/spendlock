import 'package:installed_apps/app_category.dart';

class InstalledAppCategoryMapper {
  InstalledAppCategoryMapper._();

  /// Rule category id → Android AppCategory mapping
  static AppCategory? toAppCategory(String ruleCategoryId) {
    switch (ruleCategoryId) {
      case 'social':
        return AppCategory.social;
      case 'games':
        return AppCategory.game;
      case 'travel':
        return AppCategory.maps;
      default:
        return null;
    }
  }

  /// Selected rule categories থেকে filter-able AppCategory list বানায়
  static Set<AppCategory> resolveFilterCategories(Set<String> ruleCategoryIds) {
    return ruleCategoryIds
        .map(toAppCategory)
        .whereType<AppCategory>()
        .toSet();
  }

  /// AppCategory → display label
  static String categoryLabel(AppCategory category) => category.name;
}
