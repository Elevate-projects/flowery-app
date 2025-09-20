import 'package:flowery_app/api/responses/cart_response/cart_items.dart';
import 'package:flowery_app/domain/entities/cart/cart_entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart.g.dart';
@JsonSerializable()
class Cart{
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "cartItems")
  final List<CartItemsModel>? cartItems;
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

  Cart({
    this.id,
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
        user: user,
        cartItems: cartItems?.map((e) => e.toEntity()).toList(),
        appliedCoupons: appliedCoupons,
        totalPrice: totalPrice,
        createdAt: createdAt,
        updatedAt: updatedAt,
        v: V,
        id: id
    );
  }
}