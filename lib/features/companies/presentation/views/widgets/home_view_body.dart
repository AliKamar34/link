import 'package:flutter/material.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_grid_view.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.isGrid,
    required this.isFav,
    this.makeFav,
    required this.companies,
  });

  final bool isGrid;
  final bool isFav;
  final void Function()? makeFav;
  final List<Company> companies;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: isGrid
          ? CustomGridView(
              companies: companies,
              makeFav: makeFav,
              icon: isFav ? AppAssets.redFavIcon : AppAssets.heartIcon,
            )
          : CustomListView(
              companies: companies,
              makeFav: makeFav,
              icon: isFav ? AppAssets.redFavIcon : AppAssets.heartIcon,
            ),
    );
  }
}
