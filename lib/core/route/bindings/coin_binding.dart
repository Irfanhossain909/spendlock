import 'package:get/get.dart';
import 'package:spendlock/feature/coin/presentation/controller/coin_controller.dart';

class CoinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(CoinController.new);
  }
}
