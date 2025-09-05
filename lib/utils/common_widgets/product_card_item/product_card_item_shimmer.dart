import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardItemShimmer extends StatelessWidget {
  const ProductCardItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 163.w,
      height: 229.h,
      padding: REdgeInsets.all(8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.white[70]!, width: 0.5.w),
        boxShadow: [
          BoxShadow(
            color: AppColors.white[70]!.withValues(alpha: 0.4),
            blurStyle: BlurStyle.outer,
            blurRadius: 6.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.symmetric(horizontal: 27.5, vertical: 2.5),
            height: 131.h,
            color: theme.colorScheme.onPrimary,
            child: ShimmerEffect(width: 92.w, height: 131.h, radius: 0),
          ),
          const RSizedBox(height: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ShimmerEffect(width: 57.w, height: 12.h),
                ),
                const RSizedBox(height: 4),
                Flexible(
                  child: ShimmerEffect(width: 120.w, height: 14.h),
                ),
                const RSizedBox(height: 8),
                Flexible(
                  child: ShimmerEffect(
                    width: ScreenUtil().screenWidth,
                    height: 30.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
