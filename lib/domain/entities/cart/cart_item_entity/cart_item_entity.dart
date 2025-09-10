import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

class CartItemEntity {
  final ProductCardEntity? product;
  final int? price;
  final int? quantity;
  final String? id;
  const CartItemEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
}