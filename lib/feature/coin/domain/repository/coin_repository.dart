import 'package:spendlock/core/service/api_service/api_services.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/core/utils/app_logger.dart';
import 'package:spendlock/feature/coin/domain/model/coin_model.dart';
import 'package:spendlock/feature/coin/domain/model/coin_package_model.dart';

class CoinRepository {
  CoinRepository._();
  static final CoinRepository _instance = CoinRepository._();
  static CoinRepository get instance => _instance;

  final ApiServices apiServices = ApiServices.instance;

  Future<String?> addCoin({required String packageId}) async {
    try {
      final response = await apiServices.apiPostServices(
        url: AppApiEndPoint.instance.addCoin,
        body: {"packageId": packageId},
      );

      if (response == null) return null;

      if (response["success"] == true && response["data"] is Map) {
        final paymentUrl = response["data"]["paymentUrl"];
        if (paymentUrl is String && paymentUrl.isNotEmpty) {
          return paymentUrl;
        }
      }

      return null;
    } catch (e) {
      AppLogger.error(e.toString());
      return null;
    }
  }

  Future<CoinModel?> getCoins({required int page, required int limit}) async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.coinList(page, limit),
      );

      return CoinModel.fromJson(response);
    } catch (e) {
      AppLogger.error(e.toString());
      return null;
    }
  }

  Future<CoinPackageModel?> getCoinPackages({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await apiServices.apiGetServices(
        AppApiEndPoint.coinPackageList(page, limit),
      );

      return CoinPackageModel.fromJson(response);
    } catch (e) {
      AppLogger.error(e.toString());
      return null;
    }
  }
}
