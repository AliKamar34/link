import 'package:flutter/material.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/grid_view_item.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.companies,
    this.scrollController,
    this.onToggleFavorite,
  });
  final ScrollController? scrollController;
  final Function(int)? onToggleFavorite;
  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
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
          icon: companies[index].fav
              ? AppAssets.redFavIcon
              : AppAssets.heartIcon,
          makeFav: () => onToggleFavorite?.call(companies[index].id),
        );
      },
    );
  }
}
