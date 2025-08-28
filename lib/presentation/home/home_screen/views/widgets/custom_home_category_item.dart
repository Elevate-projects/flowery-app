import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeCategoryItem extends StatelessWidget {
  const CustomHomeCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
     return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: 68.w,
            height: 64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            padding: REdgeInsets.all(12),
            child: const Image(
              image: AssetImage("assets/images/flowery_logo.png"),
            ),
          ),
        ),
        const RSizedBox(height: 8),
        Text(
          "Category",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.black
          ),
          textAlign: TextAlign.center,
        ),
      ],
         );
  }
}