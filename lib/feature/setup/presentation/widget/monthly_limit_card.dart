import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class BudgetOption {
  final String title;
  final double value;

  const BudgetOption({required this.title, required this.value});
}

class MonthlyLimitCard extends StatefulWidget {
  final double min;
  final double max;
  final double initialValue;
  final int divisions;

  /// option list
  final List<BudgetOption> options;

  /// return selected/custom value
  final Function(double value) onChanged;

  const MonthlyLimitCard({
    super.key,
    required this.onChanged,
    required this.options,
    this.min = 500,
    this.max = 5000,
    this.initialValue = 2000,
    this.divisions = 18,
  });

  @override
  State<MonthlyLimitCard> createState() => _MonthlyLimitCardState();
}

class _MonthlyLimitCardState extends State<MonthlyLimitCard> {
  late double currentValue;

  bool isEditingAmount = false;

  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();

    currentValue = widget.initialValue;

    amountController = TextEditingController(
      text: currentValue.toInt().toString(),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void updateValue(double value) {
    setState(() {
      currentValue = value;
      amountController.text = value.toInt().toString();
      isEditingAmount = false;
    });

    widget.onChanged(value);
  }

  void saveCustomValue() {
    final value = double.tryParse(amountController.text);

    if (value == null) return;

    setState(() {
      currentValue = value;
      isEditingAmount = false;
    });

    widget.onChanged(value);
  }

  bool isSelected(double value) => currentValue == value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          AppText(
            data: 'Monthly Limit',
            fontSize: 16.sp,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),

          SizedBox(height: 10.h),

          /// AMOUNT
          isEditingAmount
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: '\$',
                      fontSize: 42.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.black,
                    ),

                    IntrinsicWidth(
                      child: TextField(
                        controller: amountController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        cursorColor: AppColors.primary,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          fontSize: 42.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    GestureDetector(
                      onTap: saveCustomValue,
                      child: AppText(
                        data: 'Save',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              : AppText(
                  data: '\$${currentValue.toInt()}',
                  fontSize: 42.sp,
                  fontWeight: FontWeight.w800,
                  color: AppColors.black,
                ),

          SizedBox(height: 24.h),

          /// SLIDER
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 4.h,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.r),
            ),
            child: Slider(
              value: currentValue.clamp(widget.min, widget.max),
              min: widget.min,
              max: widget.max,
              divisions: widget.divisions,
              activeColor: AppColors.primary,
              inactiveColor: Colors.grey.shade300,
              onChanged: updateValue,
            ),
          ),

          SizedBox(height: 20.h),

          /// OPTIONS
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            alignment: WrapAlignment.center,
            children: [
              ...widget.options.map((option) {
                final selected = isSelected(option.value);

                return GestureDetector(
                  onTap: () {
                    updateValue(option.value);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: EdgeInsets.symmetric(
                      horizontal: 18.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: selected
                            ? AppColors.primary
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: AppText(
                      data: option.title,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                );
              }),

              /// CUSTOM BUTTON
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditingAmount = true;

                    amountController.text = currentValue.toInt().toString();
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: AppText(
                    data: 'Custom',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:spendlock/core/component/app_text/app_text.dart';
// import 'package:spendlock/core/const/app_color.dart';

// class BudgetOption {
//   final String title;
//   final double value;

//   const BudgetOption({required this.title, required this.value});
// }

// class MonthlyLimitCard extends StatefulWidget {
//   final double min;
//   final double max;
//   final double initialValue;

//   /// slider divisions
//   final int divisions;

//   /// option list
//   final List<BudgetOption> options;

//   /// value change callback
//   final Function(double value) onChanged;

//   const MonthlyLimitCard({
//     super.key,
//     required this.onChanged,
//     required this.options,
//     this.min = 500,
//     this.max = 5000,
//     this.initialValue = 2000,
//     this.divisions = 18,
//   });

//   @override
//   State<MonthlyLimitCard> createState() => _MonthlyLimitCardState();
// }

// class _MonthlyLimitCardState extends State<MonthlyLimitCard> {
//   late double currentValue;

//   @override
//   void initState() {
//     super.initState();
//     currentValue = widget.initialValue;
//   }

//   void updateValue(double value) {
//     setState(() {
//       currentValue = value;
//     });

//     widget.onChanged(value);
//   }

//   bool isSelected(double value) => currentValue == value;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20.r),
//         border: Border.all(color: Colors.grey.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 20,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           AppText(
//             data: 'Monthly Limit',
//             fontSize: 16.sp,
//             color: Colors.grey.shade600,
//             fontWeight: FontWeight.w500,
//           ),

//           SizedBox(height: 10.h),

//           AppText(
//             data: '\$${currentValue.toInt()}',
//             fontSize: 42.sp,
//             fontWeight: FontWeight.w800,
//             color: AppColors.black,
//           ),

//           SizedBox(height: 24.h),

//           SliderTheme(
//             data: SliderThemeData(
//               trackHeight: 4.h,
//               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
//               overlayShape: RoundSliderOverlayShape(overlayRadius: 20.r),
//             ),
//             child: Slider(
//               value: currentValue,
//               min: widget.min,
//               max: widget.max,
//               divisions: widget.divisions,
//               activeColor: AppColors.primary,
//               inactiveColor: Colors.grey.shade300,
//               onChanged: updateValue,
//             ),
//           ),

//           SizedBox(height: 20.h),

//           Wrap(
//             spacing: 12.w,
//             runSpacing: 12.h,
//             alignment: WrapAlignment.center,
//             children: widget.options.map((option) {
//               final selected = isSelected(option.value);

//               return GestureDetector(
//                 onTap: () {
//                   updateValue(option.value);
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 250),
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 18.w,
//                     vertical: 8.h,
//                   ),
//                   decoration: BoxDecoration(
//                     color: selected ? AppColors.primary : Colors.white,
//                     borderRadius: BorderRadius.circular(30.r),
//                     border: Border.all(
//                       color: selected
//                           ? AppColors.primary
//                           : Colors.grey.shade300,
//                     ),
//                   ),
//                   child: AppText(
//                     data: option.title,
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                     color: selected ? Colors.white : Colors.grey.shade600,
//                   ),
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
