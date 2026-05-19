import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spendlock/core/const/app_assets.dart';

class TreeHero extends StatelessWidget {
  const TreeHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AppAssets.moneyTree,
        width: 220.w,
        height: 220.h,
      ),
    );
  }
}
