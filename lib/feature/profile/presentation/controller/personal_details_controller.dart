import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/feature/profile/domain/repository/profile_repository.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';

class PersonalDetailsController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  bool isEditing = false;
  bool isSaving = false;
  String? profileImageUrl;
  String? selectedImagePath;

  final ProfileRepository profileRepository = ProfileRepository.instance;
  final ImagePicker _imagePicker = ImagePicker();

  static const defaultAvatarUrl =
      'https://i.pinimg.com/736x/21/09/b0/2109b0a857a0d067170dd0d2dacc1efa.jpg';

  String get displayImageUrl {
    if (profileImageUrl != null && profileImageUrl!.isNotEmpty) {
      return profileImageUrl!;
    }
    return defaultAvatarUrl;
  }

  @override
  void onInit() {
    super.onInit();
    loadPersonalDetails();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void loadPersonalDetails() {
    if (Get.isRegistered<ProfileController>()) {
      final profileData = Get.find<ProfileController>().profile.value?.data;
      if (profileData != null) {
        nameController.text = profileData.name ?? '';
        emailController.text = profileData.email ?? '';
        profileImageUrl = profileData.image;
        update();
        return;
      }
    }

    nameController.text = GetStorageServices.instance.getName();
    emailController.text = GetStorageServices.instance.getEmail();
    update();
  }

  void toggleEditing() {
    if (isEditing) {
      updateProfile();
      return;
    }
    isEditing = true;
    update();
  }

  Future<void> updateProfile() async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      Get.snackbar(
        'Error',
        'Name cannot be empty.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSaving = true;
    update();

    final success = await profileRepository.updateUserProfile(
      name: name,
      image: selectedImagePath,
    );

    isSaving = false;

    if (!success) {
      update();
      Get.snackbar(
        'Error',
        'Failed to update profile. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    selectedImagePath = null;
    isEditing = false;

    if (Get.isRegistered<ProfileController>()) {
      await Get.find<ProfileController>().getProfile();
    }

    loadPersonalDetails();
    Get.snackbar(
      'Saved',
      'Your personal details have been updated.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> pickProfileImage() async {
    if (!isEditing) {
      Get.snackbar(
        'Edit mode',
        'Tap Edit to change your photo.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image == null) return;

    selectedImagePath = image.path;
    update();
  }

  void onChangePhoto() {
    pickProfileImage();
  }
}
