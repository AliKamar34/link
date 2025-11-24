import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_task/core/theme/app_color.dart';
import 'package:link_task/core/theme/app_text_styles.dart';

class CustomDropDownButton<T> extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    this.validator,
    required this.items,
    this.onChanged,
    required this.hint,
  });
  final String? Function(T?)? validator;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      hint: Text(hint, style: AppTextStyle.styleRegular10),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      items: items.map((item) {
        return DropdownMenuItem<T>(value: item.value, child: item.child);
      }).toList(),
      decoration: InputDecoration(
        border: borderBuilder(context),
        enabledBorder: borderBuilder(context),
        focusedBorder: borderBuilder(context),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      icon: RotatedBox(
        quarterTurns: 1,
        child: const Icon(Icons.arrow_back_ios_new_outlined, size: 20),
      ),
      dropdownColor: Colors.white,
      borderRadius: BorderRadius.circular(8),
    );
  }

  OutlineInputBorder borderBuilder(BuildContext context) {
    return OutlineInputBorder(
      gapPadding: 18,
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColor.greyBorderColor),
    );
  }
}
