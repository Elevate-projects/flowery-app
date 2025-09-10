import 'package:flowery_app/domain/entities/cart/cart_entity/cart_entity.dart';
class QuantityEntity {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const QuantityEntity({
    this.message,
    this.numOfCartItems,
    this.cart,
  });
}
