import 'package:flowery_app/api/models/home_products_model/category_model.dart';
import 'package:flowery_app/api/models/home_products_model/occasion_model.dart';
import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response_model.g.dart';

@JsonSerializable()
class ProductsResponseModel {
  @JsonKey(name: "message")
  final String? message;
  
  @JsonKey(name: "products")
  final List<ProductCardModel>? products;
  
  @JsonKey(name: "categories")
  final List<CategoryModel>? categories;
  
  @JsonKey(name: "bestSeller")
  final List<ProductCardModel>? bestSeller;
  
  @JsonKey(name: "occasions")
  final List<OccasionModel>? occasions;

  const ProductsResponseModel({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ProductsResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductsResponseModelToJson(this);
  }

  ProductsResponseEntity toEntity() {
    return ProductsResponseEntity(
      message: message,
      products: products?.map((product) => product.toProductCardEntity()).toList(),
      categories: categories?.map((category) => category.toEntity()).toList(),
      bestSeller: bestSeller?.map((product) => product.toProductCardEntity()).toList(),
      occasions: occasions?.map((occasion) => occasion.toEntity()).toList(),
    );
  }
}