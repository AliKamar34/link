import 'package:flutter/material.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_selectable_button.dart';

class PersonSection extends StatelessWidget {
  const PersonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        Text('مقدم الخدمة', style: AppTextStyle.styleMedium16),

        Row(
          spacing: 20,
          children: [
            CustomSelectableButton(text: 'المكاتب الهندسية', isSelected: true),
            CustomSelectableButton(text: 'الأفراد', isSelected: false),
          ],
        ),
      ],
    );
  }
}
