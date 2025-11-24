import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_drop_down_button.dart';

class CitySection extends StatelessWidget {
  const CitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: .start,
      children: [
        Text('المدينة', style: AppTextStyle.styleMedium16),
        CustomDropDownButton<String>(
          onChanged: (value) {
            log(value.toString());
          },
          hint: 'اختر المدينة',
          items: [
            DropdownMenuItem(value: 'city 1', child: Text('city 1')),
            DropdownMenuItem(value: 'city 2', child: Text('city 2')),
          ],
        ),
      ],
    );
  }
}
