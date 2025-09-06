import 'package:equatable/equatable.dart';
import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

class OccasionProductsEntity extends Equatable {
  const OccasionProductsEntity({
    required this.listOfProducts,
    required this.occasion,
  });
  final List<ProductCardEntity> listOfProducts;
  final OccasionEntity occasion;

  @override
  List<Object?> get props => [listOfProducts, occasion];
}
