import 'package:flutter/material.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/presentation/views/widgets/categories_section.dart';
import 'package:link_task/features/companies/presentation/views/widgets/city_section.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_button.dart';
import 'package:link_task/features/companies/presentation/views/widgets/person_section.dart';

class FilteringBottomSheet extends StatelessWidget {
  const FilteringBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const .symmetric(horizontal: 16),
            child: Column(
              spacing: 32,
              crossAxisAlignment: .start,
              children: [
                Center(
                  child: Container(
                    width: 80,
                    height: 5,
                    margin: EdgeInsets.only(top: 16, bottom: 20),
                    decoration: BoxDecoration(
                      color: AppColor.darkGreyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text('تصنيف حسب', style: AppTextStyle.styleBold16),
                    Text(
                      'مسح الكل',
                      style: AppTextStyle.styleBold14.copyWith(
                        color: AppColor.redColor,
                      ),
                    ),
                  ],
                ),
                PersonSection(),
                CategoriesSection(),
                CitySection(),
                CustomButton(title: 'تطبيق', onPressed: () {}),
                SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
