import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response.g.dart';

@JsonSerializable()
class ProductsResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "products")
  final List<ProductCardModel>? products;

  ProductsResponse({this.message, this.products});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    return _$ProductsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsResponseToJson(this);
  }
}
