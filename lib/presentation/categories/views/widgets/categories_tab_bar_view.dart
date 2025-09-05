import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesTabBarView extends StatelessWidget {
  const CategoriesTabBarView({super.key, required this.categoriesProductsList});
  final List<List<ProductCardEntity>> categoriesProductsList;
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const BouncingScrollPhysics(),
      children: categoriesProductsList
          .map(
            (productsList) => GridView.builder(
              padding: REdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 17.r,
                mainAxisSpacing: 17.r,
                childAspectRatio: 1 / 1.44,
              ),
              itemBuilder: (_, index) =>
                  ProductCardItem(productCardData: productsList[index]),
              itemCount: productsList.length,
            ),
          )
          .toList(),
    );
  }
}
