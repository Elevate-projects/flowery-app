import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

class CartItemEntity {
  final ProductCardEntity? product;
  final int? price;
  int? quantity;
  final String? id;
  CartItemEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
}