import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesTabBarShimmer extends StatelessWidget {
  const CategoriesTabBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: 42.h,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: REdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    ShimmerEffect(width: 60.w, height: 24.h),
                separatorBuilder: (context, index) =>
                    const RSizedBox(width: 24),
                itemCount: 8,
              ),
            ),
            const RSizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
