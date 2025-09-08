import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response_dto.g.dart';

@JsonSerializable()
class ProductsResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "products")
  final List<ProductCardModel>? products;

  ProductsResponseDto({this.message, this.products});

  factory ProductsResponseDto.fromJson(Map<String, dynamic> json) {
    return _$ProductsResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsResponseDtoToJson(this);
  }
}
