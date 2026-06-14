import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/core/route/app_routes.dart';
import 'package:spendlock/core/service/api_service/app_api_end_point.dart';
import 'package:spendlock/feature/profile/presentation/controller/personal_details_controller.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: CustomAppbar(
            showLeading: false,
            text: 'Profile',
            centerTitle: false,
          ),
          body: ListView(
            padding: EdgeInsets.all(20.w),
            children: [
              InfoCard(),
              SizedBox(height: 20.h),
              ProfileActionCard(),
            ],
          ),
        );
      },
    );
  }
}

class ProfileActionCard extends GetView<ProfileController> {
  const ProfileActionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          _profileActionTile(
            icon: Icons.person,
            title: "Personal info",
            onTap: () => Get.toNamed(AppRoutes.instance.personalDetailsScreen),
            color: AppColors.primary,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.lock_open_outlined,
            title: "Change Password",
            onTap: () => Get.toNamed(AppRoutes.instance.changePasswordScreen),
            color: Colors.blueAccent,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.wallet,
            title: "Bank Account",
            onTap: () {
              Get.toNamed(AppRoutes.instance.connectAccountScreen);
            },
            color: Colors.orangeAccent,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.wallet,
            title: "My Coins",
            onTap: () => Get.toNamed(AppRoutes.instance.myCoinScreen),
            color: Colors.yellow,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.mediation_outlined,
            title: "My Preference",
            onTap: () => Get.toNamed(AppRoutes.instance.myPreferenceScreen),
            color: Colors.deepPurpleAccent,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.view_comfortable_outlined,
            title: "App Use",
            onTap: () => Get.toNamed(AppRoutes.instance.appUseScreen),
            color: Colors.blueGrey,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.wysiwyg_outlined,
            title: "Terms and Condition",
            onTap: () {},
            color: Colors.red,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.support_agent_rounded,
            title: "Help & Support",
            onTap: () {},
            color: Colors.green,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.verified_outlined,
            title: "About SpendLock",
            onTap: () {},
            color: Colors.grey,
            isDivider: true,
          ),
          _profileActionTile(
            icon: Icons.logout_rounded,
            title: "Log out",
            onTap: controller.logout,
            color: Colors.redAccent,
            isDivider: false,
          ),
        ],
      ),
    );
  }

  _profileActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
    required bool isDivider,
  }) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,

      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              spacing: 12.w,
              children: [
                Container(
                  padding: EdgeInsets.all(6.r),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Icon(icon, size: 16.sp, color: color),
                ),
                AppText(
                  data: title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                Spacer(),
                Icon(Icons.chevron_right, size: 20.sp, color: AppColors.black),
              ],
            ),
          ),
          if (isDivider) Divider(color: AppColors.stroke),
        ],
      ),
    );
  }
}

class InfoCard extends GetView<ProfileController> {
  const InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return AuthFormCard(
          horizontalPadding: 16.w,
          verticalPadding: 12.h,
          child: Row(
            children: [
              AppImageCircular(
                filePath: null,
                url: controller.userImage.isNotEmpty
                    ? "${AppApiEndPoint.domain}${controller.userImage}"
                    : PersonalDetailsController.defaultAvatarUrl,
                width: 68.w,
                height: 68.h,
              ),
              SizedBox(width: 12.w),
              Column(
                spacing: 4.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: controller.userName,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  AppText(
                    data: controller.userEmail,
                    fontSize: 14.sp,
                    color: AppColors.gray,
                    fontWeight: FontWeight.w400,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      spacing: 4.w,
                      children: [
                        Icon(
                          Icons.star,
                          size: 16.sp,
                          color: Colors.orangeAccent,
                        ),
                        AppText(
                          data: 'Pro member',
                          fontSize: 12.sp,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: AppText(
          data: title,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'inter',
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: AppColors.lightGray,
          size: 22.sp,
        ),
        onTap: () {},
      ),
    );
  }
}
