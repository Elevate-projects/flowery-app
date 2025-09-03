import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesGridViewShimmer extends StatelessWidget {
  const CategoriesGridViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: REdgeInsets.symmetric(horizontal: 16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 17.r,
        mainAxisSpacing: 17.r,
        childAspectRatio: 1 / 1.44,
      ),
      itemBuilder: (_, __) => const ProductCardItemShimmer(),
      itemCount: 16,
    );
  }
}
