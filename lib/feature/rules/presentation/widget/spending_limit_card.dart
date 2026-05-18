import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';
import 'package:spendlock/feature/rules/presentation/model/rule_type.dart';

typedef SpendingLimitChanged = void Function(SpendingLimitData data);

class SpendingLimitCard extends StatefulWidget {
  const SpendingLimitCard({
    super.key,
    required this.onChanged,
    this.initialAmount = 2000,
    this.initialFrequency = SpendingLimitFrequency.perDay,
    this.min = 500,
    this.max = 10000,
    this.divisions = 19,
  });

  final SpendingLimitChanged onChanged;
  final double initialAmount;
  final SpendingLimitFrequency initialFrequency;
  final double min;
  final double max;
  final int divisions;

  @override
  State<SpendingLimitCard> createState() => _SpendingLimitCardState();
}

class _SpendingLimitCardState extends State<SpendingLimitCard> {
  late double _amount;
  late SpendingLimitFrequency _frequency;

  static const _frequencies = [
    SpendingLimitFrequency.perDay,
    SpendingLimitFrequency.fullMonth,
    SpendingLimitFrequency.perWeek,
  ];

  static const _frequencyLabels = {
    SpendingLimitFrequency.perDay: 'Per Day',
    SpendingLimitFrequency.fullMonth: 'Full Month',
    SpendingLimitFrequency.perWeek: 'Per Week',
  };

  @override
  void initState() {
    super.initState();
    _amount = widget.initialAmount;
    _frequency = widget.initialFrequency;
    WidgetsBinding.instance.addPostFrameCallback((_) => _notify());
  }

  void _notify() {
    widget.onChanged(
      SpendingLimitData(amount: _amount, frequency: _frequency),
    );
  }

  void _updateAmount(double value) {
    setState(() => _amount = value);
    _notify();
  }

  void _updateFrequency(SpendingLimitFrequency frequency) {
    setState(() => _frequency = frequency);
    _notify();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.stroke),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          AppText(
            data: '\$${_formatDisplay(_amount)}',
            fontSize: 40.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.black,
            fontFamily: 'inter',
          ),
          SizedBox(height: 8.h),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4.h,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 18.r),
            ),
            child: Slider(
              value: _amount.clamp(widget.min, widget.max),
              min: widget.min,
              max: widget.max,
              divisions: widget.divisions,
              activeColor: AppColors.primary,
              inactiveColor: AppColors.lightGray.withValues(alpha: 0.35),
              onChanged: _updateAmount,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  data: 'Min: \$${widget.min.toInt()}',
                  fontSize: 11.sp,
                  color: AppColors.gray,
                  fontFamily: 'inter',
                ),
                AppText(
                  data: 'Max: \$${_formatCompact(widget.max)}',
                  fontSize: 11.sp,
                  color: AppColors.gray,
                  fontFamily: 'inter',
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: _frequencies.map((frequency) {
              final selected = _frequency == frequency;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: frequency != _frequencies.last ? 8.w : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => _updateFrequency(frequency),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.white,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: selected ? AppColors.primary : AppColors.stroke,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: AppText(
                        data: _frequencyLabels[frequency]!,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: selected ? AppColors.white : AppColors.gray,
                        fontFamily: 'inter',
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _formatDisplay(double value) {
    final digits = value.toInt().toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  String _formatCompact(double value) {
    final intValue = value.toInt();
    if (intValue >= 1000) return '${intValue ~/ 1000}k';
    return intValue.toString();
  }
}
