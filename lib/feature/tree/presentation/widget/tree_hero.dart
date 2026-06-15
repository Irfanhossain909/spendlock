import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spendlock/core/const/app_assets.dart';

class TreeHero extends StatelessWidget {
  final int totalCoins;

  const TreeHero({super.key, required this.totalCoins});

  /// Tree এর মধ্যে coin বসানোর fixed positions
  static const List<Offset> coinSlots = [
    Offset(95, 25),
    Offset(125, 30),
    Offset(70, 40),
    Offset(150, 45),
    Offset(50, 55),
    Offset(100, 60),
    Offset(135, 70),
    Offset(75, 75),
    Offset(160, 80),
    Offset(55, 90),
    Offset(115, 95),
    Offset(145, 105),
    Offset(80, 110),
    Offset(175, 115),
    Offset(45, 120),
    Offset(100, 125),
    Offset(135, 130),
    Offset(70, 140),
    Offset(155, 145),
    Offset(95, 155),
  ];

  @override
  Widget build(BuildContext context) {
    final visibleCoins = coinSlots.take(totalCoins.clamp(0, coinSlots.length));

    return SizedBox(
      width: 220.w,
      height: 220.h,
      child: Stack(
        children: [
          /// Tree Image
          Positioned.fill(
            child: SvgPicture.asset(
              AppAssets.moneyTree, // <-- change your asset path
              fit: BoxFit.contain,
            ),
          ),

          /// Coins
          ...visibleCoins.map(
            (offset) => Positioned(
              left: offset.dx.w,
              top: offset.dy.h,
              child: const _CoinWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoinWidget extends StatelessWidget {
  const _CoinWidget();

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 300),
      scale: 1,
      child: Container(
        width: 18.w,
        height: 18.w,
        decoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.orange, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withValues(alpha: 0.4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Icon(Icons.attach_money, color: Colors.white, size: 10.sp),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:spendlock/core/const/app_assets.dart';

// class TreeHero extends StatelessWidget {
//   const TreeHero({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SvgPicture.asset(
//         AppAssets.moneyTree,
//         width: 220.w,
//         height: 220.h,
//       ),
//     );
//   }
// }
