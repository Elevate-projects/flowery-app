import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "products")
  final List<ProductCardModel>? products;

  SearchResponse({this.message, this.products});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return _$SearchResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SearchResponseToJson(this);
  }
}
