import 'package:equatable/equatable.dart';
import 'package:flowery_app/domain/entities/home_products/category_entity.dart';
import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

class ProductsResponseEntity extends Equatable {
  final String? message;
  final List<ProductCardEntity>? products;
  final List<CategoryEntity>? categories;
  final List<ProductCardEntity>? bestSeller;
  final List<OccasionEntity>? occasions;

  const ProductsResponseEntity({
    this.message,
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  @override
  List<Object?> get props => [
    message,
    products,
    categories,
    bestSeller,
    occasions,
  ];
}
