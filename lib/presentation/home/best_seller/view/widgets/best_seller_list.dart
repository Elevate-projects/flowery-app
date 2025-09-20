import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerList extends StatelessWidget {
  const BestSellerList({super.key, required this.products});

  final List<ProductCardEntity> products;

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 17.r,
          mainAxisSpacing: 17.r,
          childAspectRatio: FloweryMethodHelper.currentUserToken != null
              ? 1 / 1.44
              : 1 / 1.28,
        ),
        itemBuilder: (context, index) =>
            ProductCardItem(productCardData: products[index]),
        itemCount: products.length,
      ),
    );
  }
}
