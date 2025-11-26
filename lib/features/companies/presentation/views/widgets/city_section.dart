import 'package:flutter/material.dart';
import 'package:link_task/core/theme/app_text_styles.dart';
import 'package:link_task/features/companies/domain/entities/city.dart';
import 'package:link_task/features/companies/presentation/views/widgets/custom_drop_down_button.dart';

class CitySection extends StatelessWidget {
  const CitySection({
    super.key,
    required this.cities,
    required this.onChanged,
    this.initialValue,
  });
  final List<City> cities;
  final String? initialValue;
  final void Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: .start,
      children: [
        Text('المدينة', style: AppTextStyle.styleMedium16),
        CustomDropDownButton<String>(
          initialValue: initialValue,
          onChanged: onChanged,
          hint: 'اختر المدينة',
          items: cities.map((city) {
            return DropdownMenuItem(
              value: city.id.toString(),
              child: Text(city.name, style: AppTextStyle.styleRegular12),
            );
          }).toList(),
        ),
      ],
    );
  }
}
