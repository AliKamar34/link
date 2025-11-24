import 'package:flutter/material.dart';
import 'package:link_task/features/companies/presentation/views/widgets/grid_view_item.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key, this.makeFav, required this.icon});
  final void Function()? makeFav;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        return GridViewItem(makeFav: makeFav, icon: icon);
      },
    );
  }
}
