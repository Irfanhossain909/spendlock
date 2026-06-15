import 'package:spendlock/core/service/api_service/api_services.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/streak/presentation/model/streak_model.dart';

class StreakRepository {
  StreakRepository._();
  static final StreakRepository _instance = StreakRepository._();
  static StreakRepository get instance => _instance;

  final ApiServices _apiService = ApiServices.instance;

  Future<StreakModel?> getStreak() async {
    try {
      final response = await _apiService.apiGetServices(
        AppApiEndPoint.instance.streak,
      );
      if (response == null) return null;

      if (response is List) {
        return StreakModel(data: StreakModel.parseDatumList(response));
      }

      if (response is! Map) return null;

      final map = Map<String, dynamic>.from(response);
      if (map["success"] != true && !map.containsKey("data")) {
        return null;
      }

      return StreakModel.fromJson(map);
    } catch (e, stackTrace) {
      AppLogger.error('$e\n$stackTrace');
    }

    return null;
  }
}
