import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_button/app_button.dart';
import 'package:spendlock/core/component/app_image/app_image_circular.dart';
import 'package:spendlock/core/component/app_input/app_input_field.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/component/appbar/custom_appbar.dart';
import 'package:spendlock/core/component/auth_form_card.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/profile/presentation/controller/personal_details_controller.dart';

class PersonalDetailsScreen extends GetView<PersonalDetailsController> {
  const PersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalDetailsController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CustomAppbar(
            text: 'Personal Details',
            centerTitle: false,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                _ProfileAvatarSection(controller: controller),
                SizedBox(height: 24.h),
                AuthFormCard(
                  child: Column(
                    children: [
                      AppInputField(
                        label: 'Name',
                        hint: 'Enter your name',
                        controller: controller.nameController,
                        prefixIcon: Icons.person_outline,
                        keyboardType: TextInputType.name,
                        readOnly: !controller.isEditing,
                      ),
                      SizedBox(height: 16.h),
                      AppInputField(
                        label: 'Email',
                        hint: 'Enter your email',
                        controller: controller.emailController,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: !controller.isEditing,
                      ),
                      SizedBox(height: 20.h),
                      AppButton(
                        title: controller.isEditing ? 'Save' : 'Edit',
                        isLoading: controller.isSaving,
                        onTap: controller.toggleEditing,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ProfileAvatarSection extends StatelessWidget {
  const _ProfileAvatarSection({required this.controller});

  final PersonalDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            AppImageCircular(
              url: PersonalDetailsController.defaultAvatarUrl,
              width: 100.w,
              height: 100.w,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: controller.onChangePhoto,
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.white,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: controller.onChangePhoto,
          child: AppText(
            data: 'Change photo',
            fontSize: 14.sp,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
