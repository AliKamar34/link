import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/home_view_body.dart';
import 'package:link_task/features/companies/presentation/views/widgets/list_view_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.companies,
    this.scrollController,
    this.onToggleFavorite,
    required this.isLoadingMore,
  });

  final List<Company> companies;
  final ScrollController? scrollController;
  final Function(int)? onToggleFavorite;
  final bool isLoadingMore;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: companies.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == companies.length) {
          return SizedBox(
            height: 150.h,
            child: Skeletonizer(
              child: HomeViewBody(
                companies: List.generate(
                  2,
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
                isGrid: false,
                hasMore: false,
                isLoadingMore: false,
              ),
            ),
          );
        }
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
