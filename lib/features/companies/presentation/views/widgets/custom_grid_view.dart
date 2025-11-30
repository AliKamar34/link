// import 'package:flutter/material.dart';
// import 'package:link_task/core/constants/app_assets.dart';
// import 'package:link_task/features/companies/domain/entities/company.dart';
// import 'package:link_task/features/companies/presentation/manager/notifier/favorite_notifier.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/grid_view_item.dart';
// import 'package:provider/provider.dart';

// class CustomGridView extends StatelessWidget {
//   const CustomGridView({super.key, required this.companies});

//   final List<Company> companies;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FavoriteNotifier>(
//       builder: (context, favoriteNotifier, _) {
//         return GridView.builder(
//           itemCount: companies.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             mainAxisSpacing: 16,
//             crossAxisSpacing: 16,
//             childAspectRatio: 0.9,
//           ),
//           itemBuilder: (context, index) {
//             final company = companies[index];
//             final isFavorite = favoriteNotifier.isFavorite(company.id);

//             return GridViewItem(
//               company: company,
//               icon: isFavorite ? AppAssets.redFavIcon : AppAssets.heartIcon,
//               makeFav: () => favoriteNotifier.toggleFavorite(company.id),
//             );
//           },
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/manager/notifier/favorite_notifier.dart';
import 'package:link_task/features/companies/presentation/views/widgets/grid_view_item.dart';
import 'package:provider/provider.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.companies,
    this.scrollController,
  });

  final List<Company> companies;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteNotifier>(
      builder: (context, favoriteNotifier, _) {
        return GridView.builder(
          controller: scrollController,
          itemCount: companies.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            final company = companies[index];
            final isFavorite = favoriteNotifier.isFavorite(company.id);

            return GridViewItem(
              company: company,
              icon: isFavorite ? AppAssets.redFavIcon : AppAssets.heartIcon,
              makeFav: () => favoriteNotifier.toggleFavorite(company.id),
            );
          },
        );
      },
    );
  }
}
