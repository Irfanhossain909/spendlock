import 'package:get/get.dart';
import 'package:spendlock/feature/lock_screen/presentation/controller/lock_screen_controller.dart';

class LockScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LockScreenController.new);
  }
}
