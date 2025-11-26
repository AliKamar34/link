import 'package:flutter/material.dart';
import 'package:link_task/features/companies/domain/entities/sub_category.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_selectable_button.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    super.key,
    required this.categories,
    required this.onSelect,
  });
  final List<Subcategory> categories;
  final Function(List<int>) onSelect;

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  List<int> selectedIds = [];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: List.generate(widget.categories.length, (index) {
        return CustomSelectableButton(
          onTap: () {
            setState(() {
              int id = widget.categories[index].id;

              if (selectedIds.contains(id)) {
                selectedIds.remove(id);
              } else {
                selectedIds.add(id);
              }
            });
            widget.onSelect(selectedIds);
          },
          text: widget.categories[index].name,
          isSelected: selectedIds.contains(widget.categories[index].id),
        );
      }),
    );
  }
}
