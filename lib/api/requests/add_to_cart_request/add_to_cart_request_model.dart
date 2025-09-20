import 'package:json_annotation/json_annotation.dart';

part 'add_to_cart_request_model.g.dart';

@JsonSerializable()
class AddToCartRequestModel {
  @JsonKey(name: "product")
  final String? productId;
  @JsonKey(name: "quantity")
  final int? quantity;

  AddToCartRequestModel({this.productId, this.quantity});

  factory AddToCartRequestModel.fromJson(Map<String, dynamic> json) {
    return _$AddToCartRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddToCartRequestModelToJson(this);
  }
}
