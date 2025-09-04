import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeOccassionsItemShimmer extends StatelessWidget {
  const CustomHomeOccassionsItemShimmer({super.key});
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
           child: ShimmerEffect(width: 131.w, height: 151.h),
         ),
       ),
        const RSizedBox(height: 8),
        ShimmerEffect(width: 131.w, height: 17.h)
      //  Padding(
      //    padding:  REdgeInsetsDirectional.only(start: 14.0),
      //   //  child: RSizedBox(
      //   //   width: 130,
      //   //    child: Text(
      //   //     overflow: TextOverflow.ellipsis,
      //   //     maxLines: 1,
      //   //      occasionsEntity.name ?? "",
      //   //      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //   //        color: AppColors.black,
      //   //        fontWeight: FontWeight.w500
      //   //      ),
      //   //    ),
      //   //  ),
      //  ),
     ],
        );
  }
}