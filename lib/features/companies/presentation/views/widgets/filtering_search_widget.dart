import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:link_task/core/constants/app_assets.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/features/companies/presentation/manager/cubit/companies_cubit.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_text_field.dart';
import 'package:link_task/features/companies/presentation/views/widgets/filtering_bottom_sheet.dart';

class FilteringSearchWidget extends StatefulWidget {
  const FilteringSearchWidget({super.key});

  @override
  State<FilteringSearchWidget> createState() => _FilteringSearchWidgetState();
}

class _FilteringSearchWidgetState extends State<FilteringSearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16),
      child: Row(
        spacing: 16,
        children: [
          Expanded(
            child: CustomTextField(
              hint: 'ابحث هنا عن فرد او شركة',
              prefixIcon: SvgPicture.asset(AppAssets.searchIcon),
              controller: _searchController,
              onChanged: (value) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (_searchController.text == value) {
                    if (context.mounted) {
                      context.read<CompaniesCubit>().search(value);
                    }
                  }
                });
              },
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: .vertical(top: .circular(25.r)),
                ),
                builder: (_) {
                  return BlocProvider.value(
                    value: context.read<CompaniesCubit>(),
                    child: FilteringBottomSheet(),
                  );
                },
              );
            },
            borderRadius: .circular(28.r),
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: AppColor.darkGreyColor,
              child: SvgPicture.asset(AppAssets.filterIcon),
            ),
          ),
        ],
      ),
    );
  }
}
