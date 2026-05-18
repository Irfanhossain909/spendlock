import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/streak/presentation/model/milestone_card_state.dart';
import 'package:spendlock/feature/streak/presentation/model/milestone_item.dart';

/// One milestone tile — [MilestoneItem.state] drives border, icon, and footer.
class MilestoneStreakCard extends StatelessWidget {
  const MilestoneStreakCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  final MilestoneItem item;
  final ValueChanged<MilestoneItem> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap(item),
        borderRadius: BorderRadius.circular(16.r),
        child: switch (item.state) {
          MilestoneCardState.inProgress => _InProgressBody(item: item),
          MilestoneCardState.achieved => _AchievedBody(item: item),
          MilestoneCardState.locked => _LockedBody(item: item),
        },
      ),
    );
  }
}

class _AchievedBody extends StatelessWidget {
  const _AchievedBody({required this.item});

  final MilestoneItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 14.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        children: [
          _IconRing(
            outer: AppColors.primaryMint,
            inner: AppColors.primary,
            child: Icon(Icons.check_rounded, color: AppColors.white, size: 24.sp),
          ),
          SizedBox(height: 12.h),
          AppText(
            data: item.title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'hanken',
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: AppText(
              data: 'ACHIEVED',
              fontSize: 10.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
              fontFamily: 'hanken',
              textAlign: TextAlign.center,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _InProgressBody extends StatelessWidget {
  const _InProgressBody({required this.item});

  final MilestoneItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10.h),
            padding: EdgeInsets.fromLTRB(12.w, 22.h, 12.w, 14.h),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: Column(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.timer_outlined, color: AppColors.white, size: 24.sp),
                ),
                SizedBox(height: 10.h),
                AppText(
                  data: item.title,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'hanken',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                ),
                SizedBox(height: 12.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999.r),
                  child: LinearProgressIndicator(
                    value: item.progress.clamp(0.0, 1.0),
                    minHeight: 5.h,
                    backgroundColor: AppColors.primarySurface,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: AppText(
                  data: 'IN PROGRESS',
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                  fontFamily: 'hanken',
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LockedBody extends StatelessWidget {
  const _LockedBody({required this.item});

  final MilestoneItem item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140.w,
      child: CustomPaint(
        foregroundPainter: _DashedRoundedRectPainter(
          color: AppColors.lightGray,
          strokeWidth: 1.5,
          radius: 16.r,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 14.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              _IconRing(
                outer: const Color(0xFFF0F2F5),
                inner: AppColors.lightGray,
                child: Icon(Icons.lock_outline, color: AppColors.white, size: 20.sp),
              ),
              SizedBox(height: 12.h),
              AppText(
                data: item.title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'hanken',
                textAlign: TextAlign.center,
                maxLines: 2,
                color: AppColors.lightGray,
              ),
              SizedBox(height: 12.h),
              AppText(
                data: 'LOCKED',
                fontSize: 10.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.lightGray,
                fontFamily: 'hanken',
                letterSpacing: 0.8,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconRing extends StatelessWidget {
  const _IconRing({
    required this.outer,
    required this.inner,
    required this.child,
  });

  final Color outer;
  final Color inner;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(color: outer, shape: BoxShape.circle),
      child: Center(
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(color: inner, shape: BoxShape.circle),
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _DashedRoundedRectPainter extends CustomPainter {
  _DashedRoundedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
  });

  final Color color;
  final double strokeWidth;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final r = RRect.fromRectAndRadius(
      Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth, size.height - strokeWidth),
      Radius.circular(radius),
    );
    final path = Path()..addRRect(r);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const dash = 4.0;
    const gap = 4.0;
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        final next = (d + dash).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(d, next), paint);
        d = next + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRoundedRectPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth || oldDelegate.radius != radius;
}
