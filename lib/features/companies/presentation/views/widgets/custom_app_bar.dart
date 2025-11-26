import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.icon, this.onTap});

  final String icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColor.appBarColor,
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: .circular(16),
          bottomStart: .circular(16),
        ),
      ),
      child: Padding(
        padding: .symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              'الشركات والأفراد',
              style: AppTextStyle.styleRegular16.copyWith(
                color: AppColor.textColor,
              ),
            ),
            InkWell(onTap: onTap, child: SvgPicture.asset(icon, width: 30)),
          ],
        ),
      ),
    );
  }
}
