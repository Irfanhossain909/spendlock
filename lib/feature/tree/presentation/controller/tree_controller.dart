import 'package:get/get.dart';
import 'package:spendlock/core/const/app_assets.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/core/utils/app_snackbar.dart';
import 'package:spendlock/feature/tree/domain/repository/tree_repository.dart';
import 'package:spendlock/feature/tree/presentation/model/growth_stage.dart';
import 'package:spendlock/feature/tree/presentation/model/overview_model.dart';
import 'package:spendlock/feature/tree/presentation/model/user_tree_stats.dart';

class TreeController extends GetxController {
  // repository
  final TreeRepository treeRepository = TreeRepository.instance;

  //model
  Rxn<OverViewModel> overview = Rxn<OverViewModel>();
  final totalCoins = 0.obs;
  @override
  void onInit() {
    getOverview();
    super.onInit();
  }

  Future<void> getOverview() async {
    try {
      final response = await treeRepository.getOverview();
      if (response != null) {
        overview.value = response;
        totalCoins.value = response.data?.availableCoins ?? 0;
      } else {
        AppSnackBar.error('Failed to load overview');
      }
    } catch (e) {
      AppLogger.error(e.toString());
    }
  }

  final userStats = UserTreeStats(
    currentStreakDays: 12,
    weeklyGoalProgress: 5,
    weeklyGoalTotal: 7,
    monthlySaved: 127,
    totalSaved: 543,
  ).obs;

  final growthStages = <GrowthStage>[
    const GrowthStage(
      id: 'seed',
      title: 'Seed',
      icon: AppAssets.seed,
      isActive: false,
    ),
    const GrowthStage(
      id: 'sprout',
      title: 'Sprout',
      icon: AppAssets.sprout,
      isActive: false,
    ),
    const GrowthStage(
      id: 'sapling',
      title: 'Sapling',
      icon: AppAssets.sapling,
      isActive: false,
    ),
    const GrowthStage(
      id: 'young_tree',
      title: 'Young Tree',
      icon: AppAssets.youngTree,
      isActive: true,
    ),
  ].obs;
}
