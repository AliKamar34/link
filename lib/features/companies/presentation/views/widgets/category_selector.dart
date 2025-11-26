import 'package:flutter/material.dart';
import 'package:link_task/features/companies/domain/entities/sub_category.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_selectable_button.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onSelect,
    this.initialSelectedIds,
  });

  final List<Subcategory> categories;
  final Function(List<int>) onSelect;
  final List<int>? initialSelectedIds;

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  late List<int> selectedIds;

  @override
  void initState() {
    super.initState();
    selectedIds = widget.initialSelectedIds ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(widget.categories.length, (index) {
        final category = widget.categories[index];
        return CustomSelectableButton(
          onTap: () {
            setState(() {
              if (selectedIds.contains(category.id)) {
                selectedIds.remove(category.id);
              } else {
                selectedIds.add(category.id);
              }
            });
            widget.onSelect(selectedIds);
          },
          text: category.name,
          isSelected: selectedIds.contains(category.id),
        );
      }),
    );
  }
}
