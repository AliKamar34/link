import 'package:flutter/material.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/domain/entities/sub_category.dart';
import 'package:link_task/features/companies/presentation/views/widgets/category_selector.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({
    super.key,
    required this.categories,
    required this.onSelect,
  });
  final List<Subcategory> categories;
  final Function(List<int>) onSelect;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: .start,
      children: [
        Text('الخدمات', style: AppTextStyle.styleMedium16),
        CategorySelector(
          categories: categories,
          onSelect: (selectedIDS) {
            onSelect(selectedIDS);
          },
        ),
      ],
    );
  }
}
