import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
class OrderItemEntity {
  final ProductCardEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  OrderItemEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
}