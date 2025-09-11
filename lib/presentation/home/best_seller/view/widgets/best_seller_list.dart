import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerList extends StatelessWidget {
  const BestSellerList({super.key, required this.products});

  final List<ProductCardEntity> products;

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 17.r,
          mainAxisSpacing: 17.r,
          childAspectRatio: 1 / 1.44,
        ),
        itemBuilder: (context, index) =>
            ProductCardItem(productCardData: products[index]),
        itemCount: products.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
