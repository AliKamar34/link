import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Icon(Icons.error_outline, size: 100.sp, color: AppColor.redColor),
          SizedBox(height: 24),
          Text(
            'حدث خطأ',
            style: AppTextStyle.styleBold16.copyWith(color: AppColor.textColor),
          ),
          SizedBox(height: 12),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.styleRegular12.copyWith(
              color: AppColor.darkGreyColor,
            ),
          ),
          if (onRetry != null) ...[
            SizedBox(height: 24),
            SizedBox(
              width: 150.w,
              child: CustomButton(title: 'إعادة المحاولة', onPressed: onRetry),
            ),
          ],
        ],
      ),
    );
  }
}
