import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? text;
  final List<Widget>? action;
  final bool showLeading;
  final bool autoShowLeading;
  final bool centerTitle;
  // Constructor
  const CustomAppbar({
    super.key,
    this.text,
    this.action,
    this.showLeading = true,
    this.autoShowLeading = false,
    this.centerTitle = true,
  });

  // Set the toolbarHeight to 56
  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(
        data: text ?? "No Text", // Use passed 'text' or default to "Profile"
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: autoShowLeading,
      leading: showLeading
          ? InkWell(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(Icons.arrow_back_ios, size: 18.r),
              ),
            )
          : null,
      actions: action ??
          [
          ],
    );
  }
}
