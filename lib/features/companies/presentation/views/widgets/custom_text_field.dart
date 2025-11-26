import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    this.validator,
    this.controller,
    this.prefixIcon,
    this.onChanged,
  });
  final String hint;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppColor.greyBorderColor,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColor.searchFillColor,
        errorMaxLines: 2,
        border: borderBuilder(context),
        enabledBorder: borderBuilder(context),
        focusedBorder: borderBuilder(context),
        hintText: hint,
        hintStyle: AppTextStyle.styleRegular12.copyWith(
          color: AppColor.bodyTextColor,
        ),
        prefixIcon: Padding(padding: EdgeInsets.all(16.w), child: prefixIcon),
        prefixIconConstraints: const BoxConstraints(),
        suffixIconConstraints: const BoxConstraints(),
        contentPadding: EdgeInsets.symmetric(vertical: 12.w),
      ),
    );
  }

  OutlineInputBorder borderBuilder(BuildContext context) {
    return OutlineInputBorder(
      gapPadding: 18.w,
      borderRadius: BorderRadius.circular(30.r),
      borderSide: BorderSide(color: AppColor.greyBorderColor),
    );
  }
}
