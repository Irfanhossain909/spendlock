import 'package:spendlock/core/service/api_service/api_services.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/preference/domain/model/motivation_list_model.dart';
import 'package:spendlock/feature/preference/domain/model/triger_list_model.dart';

class PreferenceRepository {
  PreferenceRepository._();
  static final PreferenceRepository _instance = PreferenceRepository._();
  static PreferenceRepository get instance => _instance;

  final ApiServices apiServices = ApiServices.instance;

  Future<MotivationListModel?> getMotivationList({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.motivationList(page, limit),
      );
      if (response["success"] == true) {
        return MotivationListModel.fromJson(response);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return null;
  }

  Future<TrigerListModel?> getTriggerList({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.triggerList(page, limit),
      );
      if (response["success"] == true) {
        return TrigerListModel.fromJson(response);
      }
      return null;
    } catch (e) {
      AppLogger.error(e.toString());
    }
    return null;
  }
}
