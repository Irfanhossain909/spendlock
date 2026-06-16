import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/tree/presentation/model/growth_stage.dart';
import 'package:spendlock/feature/tree/presentation/widget/growth_journey_card.dart';

class GrowthJourneySection extends StatelessWidget {
  const GrowthJourneySection({
    super.key,
    required this.stages,
    required this.activeIndex,
  });

  final List<GrowthStage> stages;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          data: 'GROWTH JOURNEY',
          fontSize: 12.sp,
          color: AppColors.gray,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.7,
          fontFamily: 'hanken',
        ),
        SizedBox(height: 12.h),
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: stages.length,
            itemBuilder: (context, index) {
              return GrowthJourneyCard(
                stage: stages[index],
                isActive: index == activeIndex,
              );
            },
          ),
        ),
      ],
    );
  }
}

// class GrowthJourneySection extends StatelessWidget {
//   const GrowthJourneySection({
//     super.key,
//     required this.stages,
//     required this.isActive,
//   });

//   final List<GrowthStage> stages;
//   final bool isActive;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AppText(
//           data: 'GROWTH JOURNEY',
//           fontSize: 12.sp,
//           color: AppColors.gray,
//           fontWeight: FontWeight.w600,
//           letterSpacing: 0.7,
//           fontFamily: 'hanken',
//         ),
//         SizedBox(height: 12.h),
//         SizedBox(
//           height: 120.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) =>
//                 GrowthJourneyCard(stage: stages[index], isActive: isActive),
//             itemCount: stages.length,
//           ),
//         ),
//       ],
//     );
//   }
// }
