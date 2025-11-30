// import 'package:flutter/material.dart';
// import 'package:link_task/features/companies/domain/entities/company.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/custom_grid_view.dart';
// import 'package:link_task/features/companies/presentation/views/widgets/custom_list_view.dart';

// class HomeViewBody extends StatelessWidget {
//   const HomeViewBody({
//     super.key,
//     required this.isGrid,
//     required this.companies,
//   });

//   final bool isGrid;
//   final List<Company> companies;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: isGrid
//           ? CustomGridView(companies: companies)
//           : CustomListView(companies: companies),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_grid_view.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_list_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
    required this.isGrid,
    required this.companies,
    this.scrollController,
  });

  final bool isGrid;
  final List<Company> companies;
  final ScrollController? scrollController;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: widget.isGrid
          ? CustomGridView(
              companies: widget.companies,
              scrollController: widget.scrollController,
            )
          : CustomListView(
              companies: widget.companies,
              scrollController: widget.scrollController,
            ),
    );
  }
}
