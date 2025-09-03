import 'package:json_annotation/json_annotation.dart';

part 'cart_request.g.dart';

@JsonSerializable()
class CartRequest {
  @JsonKey(name: "product")
  final String? product;
  @JsonKey(name: "quantity")
  final int? quantity;

  CartRequest ({
    this.product,
    this.quantity,
  });

  factory CartRequest.fromJson(Map<String, dynamic> json) {
    return _$CartRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CartRequestToJson(this);
  }
}


