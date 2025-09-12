import 'package:flowery_app/domain/entities/cart/cart_entity/cart_entity.dart';

class GetLoggedUserCartEntity {
  final String? message;
  final int? numOfCartItems;
  final CartEntity? cart;

  const GetLoggedUserCartEntity({
    this.message,
    this.numOfCartItems,
    this.cart,
  });
}

