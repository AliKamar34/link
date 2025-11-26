import 'package:flutter/material.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/grid_view_item.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    this.makeFav,
    required this.icon,
    required this.companies,
  });
  final void Function()? makeFav;
  final String icon;
  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: companies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        return GridViewItem(
          company: companies[index],
          makeFav: makeFav,
          icon: icon,
        );
      },
    );
  }
}
