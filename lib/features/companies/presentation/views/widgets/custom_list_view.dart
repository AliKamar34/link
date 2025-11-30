// import 'package:flutter/material.dart';
// import 'package:link_task/core/constants/app_assets.dart';
// import 'package:link_task/features/companies/domain/entities/company.dart';
// import 'package:link_task/features/companies/presentation/manager/notifier/favorite_notifier.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/list_view_item.dart';
// import 'package:provider/provider.dart';

// class CustomListView extends StatelessWidget {
//   const CustomListView({super.key, required this.companies});

//   final List<Company> companies;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<FavoriteNotifier>(
//       builder: (context, favoriteNotifier, _) {
//         return ListView.builder(
//           itemCount: companies.length,
//           itemBuilder: (context, index) {
//             final company = companies[index];
//             final isFavorite = favoriteNotifier.isFavorite(company.id);

//             return ListViewItem(
//               company: company,
//               makeFav: () => favoriteNotifier.toggleFavorite(company.id),
//               icon: isFavorite ? AppAssets.redFavIcon : AppAssets.heartIcon,
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
import 'package:link_task/features/companies/presentation/views/widgets/list_view_item.dart';
import 'package:provider/provider.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
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
        return ListView.builder(
          controller: scrollController,
          itemCount: companies.length,
          itemBuilder: (context, index) {
            final company = companies[index];
            final isFavorite = favoriteNotifier.isFavorite(company.id);

            return ListViewItem(
              company: company,
              makeFav: () => favoriteNotifier.toggleFavorite(company.id),
              icon: isFavorite ? AppAssets.redFavIcon : AppAssets.heartIcon,
            );
          },
        );
      },
    );
  }
}
