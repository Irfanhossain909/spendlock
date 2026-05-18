import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';

class PersonalDetailsController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  bool isEditing = false;
  bool isSaving = false;

  static const defaultAvatarUrl =
      'https://i.pinimg.com/736x/21/09/b0/2109b0a857a0d067170dd0d2dacc1efa.jpg';

  @override
  void onInit() {
    super.onInit();
    nameController.text = GetStorageServices.instance.getName();
    emailController.text = GetStorageServices.instance.getEmail();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void toggleEditing() {
    if (isEditing) {
      saveDetails();
      return;
    }
    isEditing = true;
    update();
  }

  Future<void> saveDetails() async {
    isSaving = true;
    update();

    await GetStorageServices.instance.setName(nameController.text.trim());
    await GetStorageServices.instance.setEmail(emailController.text.trim());

    isSaving = false;
    isEditing = false;

    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().refreshUserData();
    }

    update();
    Get.snackbar(
      'Saved',
      'Your personal details have been updated.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onChangePhoto() {
    Get.snackbar(
      'Change photo',
      'Photo upload will be available soon.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
