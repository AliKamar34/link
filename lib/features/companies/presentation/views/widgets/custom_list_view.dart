import 'package:flutter/material.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/list_view_item.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.companies,
    this.scrollController,
    this.onToggleFavorite,
  });

  final List<Company> companies;
  final ScrollController? scrollController;
  final Function(int)? onToggleFavorite;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return ListViewItem(
          company: companies[index],
          makeFav: () => onToggleFavorite?.call(companies[index].id),
          icon: companies[index].fav
              ? AppAssets.redFavIcon
              : AppAssets.heartIcon,
        );
      },
    );
  }
}
