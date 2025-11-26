import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/grid_view_item.dart';
import 'package:link_task/features/companies/presentation/views/widgets/home_view_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.companies,
    this.scrollController,
    this.onToggleFavorite,
    required this.isLoadingMore,
  });
  final ScrollController? scrollController;
  final Function(int)? onToggleFavorite;
  final List<Company> companies;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      itemCount: companies.length + (isLoadingMore ? 1 : 0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (context, index) {
        if (index == companies.length) {
          return SizedBox(
            height: 150.h,
            child: Skeletonizer(
              child: HomeViewBody(
                companies: List.generate(
                  1,
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
                isGrid: true,
              ),
            ),
          );
        }
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
