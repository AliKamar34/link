// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:link_task/core/constants/app_assets.dart';
// import 'package:link_task/features/companies/presentation/manager/cubit/companies_cubit.dart';
// import 'package:link_task/features/companies/presentation/manager/notifier/favorite_notifier.dart';
// import 'package:link_task/features/companies/presentation/manager/notifier/view_state_notifier.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/custom_app_bar.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/custom_empty_widget.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/custom_error_widget.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/custom_loading_widget.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/filtering_search_widget.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/home_view_body.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/pagination_widget.dart';
// import 'package:provider/provider.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => ViewStateNotifier()),
//         ChangeNotifierProvider(create: (_) => FavoriteNotifier()),
//       ],
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             spacing: 24,
//             children: [
//               Consumer<ViewStateNotifier>(
//                 builder: (context, viewState, _) {
//                   return CustomAppBar(
//                     onTap: viewState.toggleView,
//                     icon: viewState.isGridView
//                         ? AppAssets.grindIcon
//                         : AppAssets.menuIcon,
//                   );
//                 },
//               ),
//               FilteringSearchWidget(),
//               BlocConsumer<CompaniesCubit, CompaniesState>(
//                 listener: (context, state) {
//                   if (state is CompaniesError) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(state.message),
//                         backgroundColor: Colors.red,
//                         duration: Duration(seconds: 3),
//                       ),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is CompaniesPageLoading) {
//                     return _buildLoadedStateWithPagination(
//                       context,
//                       state.previousState,
//                       isLoading: true,
//                     );
//                   } else if (state is CompaniesLoaded) {
//                     return _buildLoadedStateWithPagination(context, state);
//                   } else if (state is CompaniesLoading) {
//                     return Consumer<ViewStateNotifier>(
//                       builder: (context, viewState, _) {
//                         return CustomLoadingWidget(
//                           isGrid: viewState.isGridView,
//                         );
//                       },
//                     );
//                   } else if (state is CompaniesEmpty) {
//                     return CustomEmptyWidget();
//                   } else if (state is CompaniesError) {
//                     return CustomErrorWidget(
//                       message: state.message,
//                       onRetry: () {
//                         context.read<CompaniesCubit>().initialize();
//                       },
//                     );
//                   } else {
//                     return CustomErrorWidget(
//                       message: 'حدث خطأ غير معروف',
//                       onRetry: () {
//                         context.read<CompaniesCubit>().initialize();
//                       },
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoadedStateWithPagination(
//     BuildContext context,
//     CompaniesLoaded state, {
//     bool isLoading = false,
//   }) {
//     return Expanded(
//       child: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 Consumer<ViewStateNotifier>(
//                   builder: (context, viewState, _) {
//                     return HomeViewBody(
//                       companies: state.companies,
//                       isGrid: viewState.isGridView,
//                     );
//                   },
//                 ),
//                 if (isLoading) CustomLoadingWidget(isGrid: true),
//               ],
//             ),
//           ),
//           if (state.pagination.lastPage > 1)
//             PaginationWidget(
//               pagination: state.pagination,
//               onPageChanged: (page) {
//                 context.read<CompaniesCubit>().goToPage(page);
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/presentation/manager/cubit/companies_cubit.dart';
import 'package:link_task/features/companies/presentation/manager/notifier/favorite_notifier.dart';
import 'package:link_task/features/companies/presentation/manager/notifier/view_state_notifier.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_app_bar.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_empty_widget.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_error_widget.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_loading_widget.dart';
import 'package:link_task/features/companies/presentation/views/widgets/filtering_search_widget.dart';
import 'package:link_task/features/companies/presentation/views/widgets/home_view_body.dart';
import 'package:link_task/features/companies/presentation/views/widgets/pagination_widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool _showPagination = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final isNearBottom = currentScroll >= (maxScroll * 0.95);

    if (isNearBottom != _showPagination) {
      setState(() {
        _showPagination = isNearBottom;
      });
    }
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ViewStateNotifier()),
        ChangeNotifierProvider(create: (_) => FavoriteNotifier()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Column(
            spacing: 24,
            children: [
              Consumer<ViewStateNotifier>(
                builder: (context, viewState, _) {
                  return CustomAppBar(
                    onTap: viewState.toggleView,
                    icon: viewState.isGridView
                        ? AppAssets.grindIcon
                        : AppAssets.menuIcon,
                  );
                },
              ),
              FilteringSearchWidget(),
              BlocConsumer<CompaniesCubit, CompaniesState>(
                listener: (context, state) {
                  if (state is CompaniesError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CompaniesPageLoading) {
                    return Consumer<ViewStateNotifier>(
                      builder: (context, viewState, _) {
                        return CustomLoadingWidget(
                          isGrid: viewState.isGridView,
                        );
                      },
                    );
                  } else if (state is CompaniesLoaded) {
                    return _buildLoadedStateWithPagination(context, state);
                  } else if (state is CompaniesLoading) {
                    return Consumer<ViewStateNotifier>(
                      builder: (context, viewState, _) {
                        return CustomLoadingWidget(
                          isGrid: viewState.isGridView,
                        );
                      },
                    );
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
      ),
    );
  }

  Widget _buildLoadedStateWithPagination(
    BuildContext context,
    CompaniesLoaded state,
  ) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Consumer<ViewStateNotifier>(
              builder: (context, viewState, _) {
                return HomeViewBody(
                  companies: state.companies,
                  isGrid: viewState.isGridView,
                  scrollController: _scrollController,
                );
              },
            ),
          ),
          if (state.pagination.lastPage > 1)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _showPagination
                  ? Padding(
                      padding: const .only(top: 8.0),
                      child: PaginationWidget(
                        pagination: state.pagination,
                        onPageChanged: (page) {
                          context.read<CompaniesCubit>().goToPage(page);
                          _scrollToTop();
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
        ],
      ),
    );
  }
}
