import 'package:get/get.dart';
import 'package:spendlock/feature/preference/presentation/controller/preference_controller.dart';

class PreferenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(PreferenceController.new, fenix: true);
  }
}
