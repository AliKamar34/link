import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_button.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        spacing: 16,
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          SvgPicture.asset(AppAssets.noResultImage),
          Column(
            spacing: 6,
            children: [
              Text(
                'عذرًا، لم نعثر على نتائج!',
                style: AppTextStyle.styleMedium14.copyWith(
                  color: AppColor.textColor,
                ),
              ),
              Text(
                'من فضلك حاول مجددًا باستخدام جمل بحث أخري',
                style: AppTextStyle.styleRegular12.copyWith(
                  color: AppColor.bodyTextColor,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 150.w,
            child: CustomButton(
              borderRadius: 55.r,
              title: 'البحث مجددًا',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
