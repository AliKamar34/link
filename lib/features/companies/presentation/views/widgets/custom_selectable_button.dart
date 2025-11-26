import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';

class CustomSelectableButton extends StatelessWidget {
  const CustomSelectableButton({
    super.key,
    required this.text,
    required this.isSelected,
    this.onTap,
  });
  final String text;
  final bool isSelected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: 148.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor.withAlpha(46)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected
                ? AppColor.greenBorderColor
                : AppColor.searchBorderColor,
          ),
        ),
        child: Text(
          text,
          textAlign: .center,
          style: AppTextStyle.styleMedium14.copyWith(color: AppColor.textColor),
        ),
      ),
    );
  }
}
