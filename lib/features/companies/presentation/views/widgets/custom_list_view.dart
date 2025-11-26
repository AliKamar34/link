import 'package:flutter/material.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/list_view_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
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
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return ListViewItem(
          company: companies[index],
          makeFav: makeFav,
          icon: icon,
        );
      },
    );
  }
}
