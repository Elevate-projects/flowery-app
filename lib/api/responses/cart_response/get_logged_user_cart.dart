import 'package:flowery_app/api/responses/cart_response/cart.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_logged_user_cart.g.dart';

@JsonSerializable()
class GetLoggedUserCartModel {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final Cart? cart;

  GetLoggedUserCartModel ({
    this.message,
    this.numOfCartItems,
    this.cart,
  });

  factory GetLoggedUserCartModel.fromJson(Map<String, dynamic> json) {
    return _$GetLoggedUserCartModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$GetLoggedUserCartModelToJson(this);
  }
  GetLoggedUserCartEntity toEntity() {
    return GetLoggedUserCartEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart!.toEntity(),
    );
  }
}


