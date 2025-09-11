import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/home/best_seller/view/widgets/best_seller_app_bar.dart';
import 'package:flowery_app/presentation/home/best_seller/view/widgets/best_seller_list.dart';
import 'package:flutter/material.dart';

class BestSellerView extends StatelessWidget {
  const BestSellerView({super.key, required this.products});

  final List<ProductCardEntity> products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BestSellerAppBar(),
      body: BestSellerList(products: products),
    );
  }
}
