import 'package:get/get.dart';
import 'package:spendlock/feature/setup/presentation/controller/setup_controller.dart';

class SetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(SetupController.new, fenix: true);
  }
}
