import 'package:flutter/material.dart';
import 'package:link_task/features/companies/presentation/views/widgets/list_view_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({super.key, this.makeFav, required this.icon});
  final void Function()? makeFav;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListViewItem(makeFav: makeFav, icon: icon);
      },
    );
  }
}
