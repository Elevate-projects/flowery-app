import 'package:flowery_app/api/responses/cart_response/cart.dart';
import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quantity_response.g.dart';

@JsonSerializable()
class QuantityResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final Cart? cart;

  QuantityResponse ({
    this.message,
    this.numOfCartItems,
    this.cart,
  });

  factory QuantityResponse.fromJson(Map<String, dynamic> json) {
    return _$QuantityResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuantityResponseToJson(this);
  }
  QuantityEntity toQuantityEntity(){
    return QuantityEntity(
      message: message,
      numOfCartItems: numOfCartItems,
      cart: cart?.toEntity(),
    );
  }
}



