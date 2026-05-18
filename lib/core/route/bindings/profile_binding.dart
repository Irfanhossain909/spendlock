import 'package:get/get.dart';
import 'package:spendlock/feature/profile/presentation/controller/change_password_controller.dart';
import 'package:spendlock/feature/profile/presentation/controller/personal_details_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PersonalDetailsController.new, fenix: true);
    Get.lazyPut(ChangePasswordController.new, fenix: true);
  }
}
