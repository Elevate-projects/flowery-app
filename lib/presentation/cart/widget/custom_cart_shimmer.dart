import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomCartDetailsShimmer extends StatelessWidget {
  const CustomCartDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16.h,
                    width: 120.w,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 14.h,
                    width: 80.w,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    height: 20.h,
                    width: 60.w,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 20.w,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  height: 20.w,
                  width: 20.w,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}