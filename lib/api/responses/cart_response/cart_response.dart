import 'package:flowery_app/api/responses/cart_response/cart.dart';
import 'package:flowery_app/domain/entities/cart/add_product_to_cart/add_product_cart_entity.dart';

import 'package:json_annotation/json_annotation.dart';

  part 'cart_response.g.dart';

  @JsonSerializable()
  class CartResponse {
    @JsonKey(name: "message")
    final String? message;
    @JsonKey(name: "numOfCartItems")
    final int? numOfCartItems;
    @JsonKey(name: "cart")
    final Cart? cart;

    CartResponse ({
      this.message,
      this.numOfCartItems,
      this.cart,
    });

    factory CartResponse.fromJson(Map<String, dynamic> json) {
      return _$CartResponseFromJson(json);
    }

    Map<String, dynamic> toJson() {
      return _$CartResponseToJson(this);
    }

    AddProductCartEntity toEntity() {
      return AddProductCartEntity(
        message: message,
        numOfCartItems: numOfCartItems,
        cart: cart?.toEntity(),
      );
    }
  }