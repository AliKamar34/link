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
  List<int> selectedSubCategoryIds = [];
  int? selectedCityId;
  String? selectedType;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, controller) {
        return SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: const .symmetric(horizontal: 16),
            child: Column(
              spacing: 32,
              crossAxisAlignment: .start,
              children: [
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: 80,
                        height: 5,
                        margin: EdgeInsets.only(top: 16, bottom: 20),
                        decoration: BoxDecoration(
                          color: AppColor.darkGreyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('تصنيف حسب', style: AppTextStyle.styleBold16),
                        InkWell(
                          onTap: () {
                            context.read<CompaniesCubit>().clearFilters();
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
                  onSelect: (type) {
                    selectedType = type;
                  },
                ),
                CategoriesSection(
                  onSelect: (selectedIDS) {
                    selectedSubCategoryIds = selectedIDS;
                  },
                  categories: context.read<CompaniesCubit>().subCategoriesList,
                ),
                CitySection(
                  onChanged: (value) {
                    selectedCityId = value == null ? null : int.parse(value);
                  },
                  cities: context.read<CompaniesCubit>().citiesList,
                ),
                CustomButton(
                  title: 'تطبيق',
                  onPressed: () {
                    context.read<CompaniesCubit>().applyFilters(
                      cityId: selectedCityId,
                      type: selectedType,
                      subCategoryIds: selectedSubCategoryIds,
                    );
                    Navigator.pop(context);
                  },
                ),
                SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
