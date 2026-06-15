import 'package:spendlock/core/service/api_service/api_services.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/tree/presentation/model/overview_model.dart';

class TreeRepository {
  TreeRepository._();

  static final TreeRepository _instance = TreeRepository._();
  static TreeRepository get instance => _instance;

  final ApiServices apiServices = ApiServices.instance;

  Future<OverViewModel?> getOverview() async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.instance.overview,
      );
      if (response == null || response is! Map) {
        return null;
      }

      final map = Map<String, dynamic>.from(response);
      if (map["success"] == true || map.containsKey("data")) {
        return OverViewModel.fromJson(map);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return null;
  }
}
