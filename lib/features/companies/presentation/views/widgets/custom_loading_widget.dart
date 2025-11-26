import 'package:flutter/material.dart';
import 'package:link_task/features/companies/domain/entities/company.dart';
import 'package:link_task/features/companies/presentation/views/widgets/home_view_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key, required this.isGrid});

  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        child: HomeViewBody(
          companies: List.generate(
            6,
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
          hasMore: false,
          isLoadingMore: false,
        ),
      ),
    );
  }
}
