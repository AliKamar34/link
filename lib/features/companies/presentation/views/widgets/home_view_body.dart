import 'package:flutter/material.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_grid_view.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_list_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
    required this.isGrid,
    required this.isFav,
    this.makeFav,
  });

  final bool isGrid;
  final bool isFav;
  final void Function()? makeFav;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const .symmetric(horizontal: 16),
        child: isGrid
            ? CustomGridView(
                makeFav: makeFav,
                icon: isFav ? AppAssets.redFavIcon : AppAssets.heartIcon,
              )
            : CustomListView(
                makeFav: makeFav,
                icon: isFav ? AppAssets.redFavIcon : AppAssets.heartIcon,
              ),
      ),
    );
  }
}
