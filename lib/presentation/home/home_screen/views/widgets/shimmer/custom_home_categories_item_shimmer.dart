import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeCategoryItemShimmer extends StatelessWidget {
  const CustomHomeCategoryItemShimmer({super.key});

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
            child: ShimmerEffect(
              width: 68.w,
              height: 64.h,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ShimmerEffect(width: 52.w, height: 17.h),
      ],
    );
  }
}
