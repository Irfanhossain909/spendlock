import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/profile/presentation/controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: const Text('Profile')),
          body: Obx(
            () => ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundColor: AppColors.primarySurface,
                        child: Icon(Icons.person, size: 40.sp, color: AppColors.primary),
                      ),
                      SizedBox(height: 12.h),
                      AppText(
                        data: controller.userName.value,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                _ProfileTile(icon: Icons.account_balance_wallet_outlined, title: 'Monthly Budget'),
                _ProfileTile(icon: Icons.notifications_outlined, title: 'Notifications'),
                _ProfileTile(icon: Icons.security_outlined, title: 'Security'),
                _ProfileTile(icon: Icons.help_outline, title: 'About SpendLock'),
                SizedBox(height: 24.h),
                ListTile(
                  leading: Icon(Icons.logout, color: AppColors.red, size: 22.sp),
                  title: AppText(
                    data: 'Log out',
                    fontSize: 16.sp,
                    color: AppColors.red,
                    fontWeight: FontWeight.w600,
                  ),
                  onTap: controller.logout,
                ),
              ],
            ),
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
        title: AppText(data: title, fontSize: 15.sp, fontWeight: FontWeight.w500, fontFamily: 'inter'),
        trailing: Icon(Icons.chevron_right, color: AppColors.lightGray, size: 22.sp),
        onTap: () {},
      ),
    );
  }
}
