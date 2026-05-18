import 'package:get/get.dart';
import 'package:spendlock/feature/auth/presentation/controller/login_controller.dart';
import 'package:spendlock/feature/auth/presentation/controller/register_controller.dart';
import 'package:spendlock/feature/auth/presentation/controller/reset_password_controller.dart';
import 'package:spendlock/feature/auth/presentation/controller/verify_email_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(LoginController.new);
    Get.lazyPut(RegisterController.new);
    Get.lazyPut(VerifyEmailController.new);
    Get.lazyPut(ResetPasswordController.new);
  }
}
