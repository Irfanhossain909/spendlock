import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/home/presentation/ui/home_screen.dart';
import 'package:spendlock/feature/navigation/presentation/controller/navigation_controller.dart';
import 'package:spendlock/feature/profile/presentation/ui/profile_screen.dart';
import 'package:spendlock/feature/rules/presentation/ui/rules_screen.dart';
import 'package:spendlock/feature/streak/presentation/ui/streak_screen.dart';
import 'package:spendlock/feature/tree/presentation/ui/tree_screen.dart';

class NavigationScreen extends GetView<NavigationController> {
  const NavigationScreen({super.key});

  static const _tabs = [
    (Icons.home_outlined, Icons.home, 'Home'),
    (Icons.description_outlined, Icons.description, 'Rules'),
    (Icons.eco_outlined, Icons.eco, 'Tree'),
    (
      Icons.local_fire_department_outlined,
      Icons.local_fire_department,
      'Streak',
    ),
    (Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      builder: (controller) {
        return Scaffold(
          body: Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: [
                const HomeScreen(),
                const RulesScreen(),
                const TreeScreen(),
                const StreakScreen(),
                const ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: Obx(
            () => Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                border: const Border(top: BorderSide(color: AppColors.stroke)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  height: 64.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(_tabs.length, (index) {
                      final tab = _tabs[index];
                      final selected = controller.selectedIndex.value == index;
                      return InkWell(
                        onTap: () => controller.changeIndex(index),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              selected ? tab.$2 : tab.$1,
                              size: 24.sp,
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.lightGray,
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              tab.$3,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                                color: selected
                                    ? AppColors.primary
                                    : AppColors.lightGray,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
