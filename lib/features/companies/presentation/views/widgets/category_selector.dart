import 'package:flutter/material.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_selectable_button.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> categories = [
      'إستشارات هندسية',
      'لاند سكيب',
      'تصاميم واجهات خارجية',
      'تصاميم داخلية',
      'مساحة',
      'إشراف',
    ];
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(categories.length, (index) {
        return CustomSelectableButton(
          text: categories[index],
          isSelected: false,
        );
      }),
    );
  }
}
