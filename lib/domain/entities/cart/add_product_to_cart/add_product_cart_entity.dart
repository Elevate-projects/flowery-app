import 'package:flowery_app/domain/entities/cart/cart_entity/cart_entity.dart';
class AddProductCartEntity {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const AddProductCartEntity({
    this.message,
    this.numOfCartItems,
    this.cart,
  });
}

