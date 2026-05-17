import 'package:get/get.dart';
import 'package:spendlock/feature/onboarding/presentation/controller/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(OnboardingController.new, fenix: true);
  }
}
