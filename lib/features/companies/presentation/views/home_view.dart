import 'package:flutter/material.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_app_bar.dart';
import 'package:link_task/features/companies/presentation/views/widgets/filtering_search_widget.dart';
import 'package:link_task/features/companies/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isGrid = false;
  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          spacing: 24,
          children: [
            CustomAppBar(
              onTap: () {
                setState(() {
                  isGrid = !isGrid;
                });
              },
              icon: isGrid ? AppAssets.grindIcon : AppAssets.menuIcon,
            ),

            FilteringSearchWidget(),
            HomeViewBody(
              isGrid: isGrid,
              isFav: isFav,
              makeFav: () {
                setState(() {
                  isFav = !isFav;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
