import 'package:flutter/material.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_selectable_button.dart';

class PersonSection extends StatefulWidget {
  const PersonSection({super.key, required this.onSelect, this.initialType});

  final Function(String?) onSelect;
  final String? initialType;

  @override
  State<PersonSection> createState() => _PersonSectionState();
}

class _PersonSectionState extends State<PersonSection> {
  String? selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.initialType;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('مقدم الخدمة', style: AppTextStyle.styleMedium16),
        Row(
          spacing: 20,
          children: [
            CustomSelectableButton(
              onTap: () {
                setState(() {
                  selectedType = selectedType == 'office' ? null : 'office';
                });
                widget.onSelect(selectedType);
              },
              text: 'المكاتب الهندسية',
              isSelected: selectedType == 'office',
            ),
            CustomSelectableButton(
              onTap: () {
                setState(() {
                  selectedType = selectedType == 'person' ? null : 'person';
                });
                widget.onSelect(selectedType);
              },
              text: 'الأفراد',
              isSelected: selectedType == 'person',
            ),
          ],
        ),
      ],
    );
  }
}
