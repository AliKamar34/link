import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/presentation/manager/cubit/companies_cubit.dart';
import 'package:link_task/features/companies/presentation/views/widgets/categories_section.dart';
import 'package:link_task/features/companies/presentation/views/widgets/city_section.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_button.dart';
import 'package:link_task/features/companies/presentation/views/widgets/person_section.dart';

class FilteringBottomSheet extends StatefulWidget {
  const FilteringBottomSheet({super.key});

  @override
  State<FilteringBottomSheet> createState() => _FilteringBottomSheetState();
}

class _FilteringBottomSheetState extends State<FilteringBottomSheet> {
  late List<int> selectedSubCategoryIds;
  late int? selectedCityId;
  late String? selectedType;

  @override
  void initState() {
    super.initState();
    final state = context.read<CompaniesCubit>().state;
    if (state is CompaniesLoaded) {
      selectedSubCategoryIds = state.currentSubCategoryIds ?? [];
      selectedCityId = state.currentCityId;
      selectedType = state.currentType;
    } else {
      selectedSubCategoryIds = [];
      selectedCityId = null;
      selectedType = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CompaniesCubit>();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 32,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: 80,
                        height: 5,
                        margin: const EdgeInsets.only(top: 16, bottom: 20),
                        decoration: BoxDecoration(
                          color: AppColor.darkGreyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('تصنيف حسب', style: AppTextStyle.styleBold16),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedSubCategoryIds = [];
                              selectedCityId = null;
                              selectedType = null;
                            });
                            cubit.clearFilters();
                            Navigator.pop(context);
                          },
                          child: Text(
                            'مسح الكل',
                            style: AppTextStyle.styleBold14.copyWith(
                              color: AppColor.redColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                PersonSection(
                  initialType: selectedType,
                  onSelect: (type) {
                    setState(() {
                      selectedType = type;
                    });
                  },
                ),
                CategoriesSection(
                  initialSelectedIds: selectedSubCategoryIds,
                  onSelect: (selectedIDs) {
                    setState(() {
                      selectedSubCategoryIds = selectedIDs;
                    });
                  },
                  categories: cubit.subCategoriesList,
                ),
                CitySection(
                  initialValue: selectedCityId?.toString(),
                  onChanged: (value) {
                    setState(() {
                      selectedCityId = value == null ? null : int.parse(value);
                    });
                  },
                  cities: cubit.citiesList,
                ),
                CustomButton(
                  title: 'تطبيق',
                  onPressed: () {
                    cubit.applyFilters(
                      cityId: selectedCityId,
                      type: selectedType,
                      subCategoryIds: selectedSubCategoryIds.isEmpty
                          ? null
                          : selectedSubCategoryIds,
                    );
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
