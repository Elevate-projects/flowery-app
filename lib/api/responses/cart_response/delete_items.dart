import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_items.g.dart';

@JsonSerializable()
class DeleteItems {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final Cart? cart;

  DeleteItems ({
    this.message,
    this.numOfCartItems,
    this.cart,
  });

  factory DeleteItems.fromJson(Map<String, dynamic> json) {
    return _$DeleteItemsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$DeleteItemsToJson(this);
  }
  DeleteItemsEntity toEntity() {
    return DeleteItemsEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart?.toEntity(),
    );
  }
}

@JsonSerializable()
class Cart {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "cartItems")
  final List<dynamic>? cartItems;
  @JsonKey(name: "appliedCoupons")
  final List<dynamic>? appliedCoupons;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;

  Cart ({
    this.Id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.V,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return _$CartFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartToJson(this);
  }
  CartEntity toEntity() {
    return CartEntity(
      id: Id,
      user: user,
      cartItems: cartItems,
      appliedCoupons: appliedCoupons,
      totalPrice: totalPrice,
      createdAt: createdAt,
      updatedAt: updatedAt,
      v: V,
    );
  }
}


