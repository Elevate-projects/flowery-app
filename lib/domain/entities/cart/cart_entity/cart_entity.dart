import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';

class CartEntity {
  final String? id;
  final String? user;
  final List<CartItemEntity>? cartItems;
  final List<dynamic>? appliedCoupons;
  int? totalPrice;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  CartEntity({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });
}
