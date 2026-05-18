import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spendlock/core/component/app_text/app_text.dart';
import 'package:spendlock/core/const/app_color.dart';

class AppInputField extends StatefulWidget {
  const AppInputField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.isPassword = false,
    this.readOnly = false,
    this.keyboardType,
    this.validator,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final bool isPassword;
  final bool readOnly;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          data: widget.label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.gray,
        ),
        SizedBox(height: 12.h),
        TextFormField(
          controller: widget.controller,
          readOnly: widget.readOnly,
          obscureText: widget.isPassword && _obscure,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: GoogleFonts.inter(fontSize: 14.sp, color: AppColors.black),
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, size: 20.sp, color: AppColors.gray)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20.sp,
                      color: AppColors.gray,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
