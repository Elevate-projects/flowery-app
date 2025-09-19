import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
class CustomCartDetailsShimmer extends StatelessWidget {
  const CustomCartDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.secondary,
      highlightColor: theme.colorScheme.shadow,
      child: Container(
        margin: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: REdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: theme.colorScheme.shadow.withAlpha(2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80.r,
              height: 80.r,
              decoration: BoxDecoration(
                color:theme.colorScheme.shadow.withAlpha(2),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            const RSizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16.h,
                    width: 120.w,
                    color: theme.colorScheme.shadow.withAlpha(2)
                  ),
                  const RSizedBox(height: 8),
                  Container(
                    height: 14.h,
                    width: 80.w,
                    color: theme.colorScheme.shadow.withAlpha(2),
                  ),
                  const RSizedBox(height: 12),
                  Container(
                    height: 20.h,
                    width: 60.w,
                    color: theme.colorScheme.shadow.withAlpha(2),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 20.r,
                  width: 20.r,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.shadow.withAlpha(2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                const RSizedBox(height: 12),
                Container(
                  height: 20.r,
                  width: 20.r,
                  decoration: BoxDecoration(
                    color:theme.colorScheme.shadow.withAlpha(2),
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
