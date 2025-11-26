import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/presentation/manager/cubit/companies_cubit.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_app_bar.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_empty_widget.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_error_widget.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_loading_widget.dart';
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
            BlocBuilder<CompaniesCubit, CompaniesState>(
              builder: (context, state) {
                if (state is CompaniesLoaded) {
                  return Expanded(
                    child: HomeViewBody(
                      companies: state.companies,
                      isGrid: isGrid,
                      hasMore: state.pagination.hasNextPage,
                      onLoadMore: () {
                        context.read<CompaniesCubit>().loadMore();
                      },
                      onToggleFavorite: (companyId) {
                        context.read<CompaniesCubit>().toggleFavorite(
                          companyId,
                        );
                      },
                    ),
                  );
                } else if (state is CompaniesLoadingMore) {
                  return Expanded(
                    child: HomeViewBody(
                      companies: state.currentCompanies,
                      isGrid: isGrid,
                      isLoadingMore: true,
                    ),
                  );
                } else if (state is CompaniesLoading) {
                  return CustomLoadingWidget(isGrid: isGrid);
                } else if (state is CompaniesEmpty) {
                  return CustomEmptyWidget();
                } else if (state is CompaniesError) {
                  return CustomErrorWidget(
                    message: state.message,
                    onRetry: () {
                      context.read<CompaniesCubit>().initialize();
                    },
                  );
                } else {
                  // inital state
                  return CustomErrorWidget(
                    message: 'حدث خطأ غير معروف',
                    onRetry: () {
                      context.read<CompaniesCubit>().initialize();
                    },
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
