import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: .symmetric(vertical: 10),
        minimumSize: Size(double.infinity, 55.h),
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: AppTextStyle.styleMedium16.copyWith(color: Colors.white),
      ),
    );
  }
}
