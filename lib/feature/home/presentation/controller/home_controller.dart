import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/service/api_service/get_storage_services.dart';
import 'package:spendlock/feature/profile/presentation/controller/personal_details_controller.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';

class HomeController extends GetxController {
  final userName = ''.obs;
  final profileImageUrl = RxnString();
  final streakDays = 12.obs;
  final weeklyProgress = 5.obs;
  final totalSavings = 2450.0.obs;
  final coins = 12.obs;

  String get displayImageUrl {
    final image = profileImageUrl.value;
    if (image != null && image.isNotEmpty) {
      return image;
    }
    return PersonalDetailsController.defaultAvatarUrl;
  }

  final activeRules = <ActiveRule>[
    ActiveRule(
      title: 'No food delivery after 9 PM',
      subtitle: '02:14h left',
      icon: Icons.access_time,
      iconBg: 0xFFE0F5F2,
    ),
    ActiveRule(
      title: 'Weekly Dining',
      subtitle: 'Max \$200',
      icon: Icons.attach_money,
      iconBg: 0xFFFFF4D6,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    loadPersonalDetails();

    if (Get.isRegistered<ProfileController>()) {
      ever(Get.find<ProfileController>().profile, (_) => loadPersonalDetails());
    }
  }

  void loadPersonalDetails() {
    if (Get.isRegistered<ProfileController>()) {
      final profileData = Get.find<ProfileController>().profile.value?.data;
      if (profileData != null) {
        userName.value = profileData.name ?? '';
        profileImageUrl.value = profileData.image;
        return;
      }
    }

    userName.value = GetStorageServices.instance.getName();
    profileImageUrl.value = null;
  }
}

class ActiveRule {
  ActiveRule({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final int iconBg;
}
