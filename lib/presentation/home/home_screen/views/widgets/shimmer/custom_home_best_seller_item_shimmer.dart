import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeBestSellerItemShimmer extends StatelessWidget {
  const CustomHomeBestSellerItemShimmer({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RSizedBox(
            width: 131.w,
            height: 151.h,
            child:ShimmerEffect(width: 131.w, height: 151.h)
            
          ),
        ),
        const RSizedBox(height: 8),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerEffect(width: 131.w, height: 15.h),
              const RSizedBox(height: 4),
              ShimmerEffect(width: 131.w, height: 17.h)
            ],
          ),
        ),
      ],
    );
  }
}
