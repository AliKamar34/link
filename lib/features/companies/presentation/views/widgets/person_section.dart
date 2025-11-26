import 'package:flutter/material.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_selectable_button.dart';

class PersonSection extends StatefulWidget {
  const PersonSection({super.key, required this.onSelect});
  final Function(String) onSelect;
  @override
  State<PersonSection> createState() => _PersonSectionState();
}

class _PersonSectionState extends State<PersonSection> {
  int selectedIndex = 0;
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
            CustomSelectableButton(
              onTap: () {
                setState(() {
                  selectedIndex = 0;
                });
                widget.onSelect('office');
              },
              text: 'المكاتب الهندسية',
              isSelected: selectedIndex == 0 ? true : false,
            ),
            CustomSelectableButton(
              onTap: () {
                setState(() {
                  selectedIndex = 1;
                });
                widget.onSelect('person');
              },
              text: 'الأفراد',
              isSelected: selectedIndex == 1 ? true : false,
            ),
          ],
        ),
      ],
    );
  }
}
