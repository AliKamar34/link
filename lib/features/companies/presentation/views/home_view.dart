import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/manager/cubit/companies_cubit.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_app_bar.dart';
import 'package:link_task/features/companies/presentation/views/widgets/filtering_search_widget.dart';
import 'package:link_task/features/companies/presentation/views/widgets/home_view_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            BlocBuilder<CompaniesCubit, CompaniesState>(
              builder: (context, state) {
                if (state is CompaniesLoaded) {
                  return Expanded(
                    child: HomeViewBody(
                      companies: state.companies,
                      isGrid: isGrid,
                      isFav: isFav,
                      makeFav: () {
                        setState(() {
                          isFav = !isFav;
                        });
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    child: Skeletonizer(
                      child: HomeViewBody(
                        companies: List.generate(
                          5,
                          (index) => Company(
                            id: 1,
                            name: 'name company',
                            type: 'type person',
                            img: 'img url',
                            desc:
                                ' هذا النص هو مثال لنص يمكن استبداله في نفس المساحه لقد تم توليد هذا النص من مولد النص العربي, 3.0,',
                            avgRates: '2.5',
                            fav: false,
                            location: 'location',
                          ),
                        ),
                        isGrid: isGrid,
                        isFav: isFav,
                        makeFav: () {},
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
