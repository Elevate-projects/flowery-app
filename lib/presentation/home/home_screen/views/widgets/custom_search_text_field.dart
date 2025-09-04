import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: '',
      hintText: 'Search for products...',
      keyboardType: TextInputType.text,
      prefixIcon: Row(
  mainAxisSize: MainAxisSize.min, // keeps it compact
  children: [
    const SizedBox(width: 8),
    Icon(Icons.search, color: Colors.grey[600], size: 20),
    const SizedBox(width: 6),
    Text(
      "Search",
      style: TextStyle(color: Colors.grey[600], fontSize: 14),
    ),
  ],
),
prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      borderRadius: 8, // Rounded border for search field
      style: TextStyle(fontSize: 14.sp, color: AppColors.black),
      hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[500]),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    );
  }
}
