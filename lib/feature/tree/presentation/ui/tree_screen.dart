import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/tree/presentation/controller/tree_controller.dart';

class TreeScreen extends GetView<TreeController> {
  const TreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TreeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(title: const Text('Money Tree')),
          body: Obx(
            () => Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Icon(Icons.park, size: 160.sp, color: AppColors.primary),
                  SizedBox(height: 24.h),
                  AppText(
                    data: 'Your savings garden',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.h),
                  AppText(
                    data:
                        'Every avoided purchase helps your Money Tree grow. Level ${controller.growthLevel.value} unlocked!',
                    fontSize: 14.sp,
                    color: AppColors.gray,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                  SizedBox(height: 32.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryMint,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        AppText(
                          data: 'Total saved',
                          fontSize: 14.sp,
                          color: AppColors.primary,
                          fontFamily: 'hanken',
                        ),
                        SizedBox(height: 8.h),
                        AppText(
                          data: '\$${controller.totalSaved.value.toStringAsFixed(0)}',
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                          fontFamily: 'inter',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
