import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

class OccasionArgumentsEntity {
  const OccasionArgumentsEntity({
    required this.listOfProducts,
    required this.occasions,
  });
  final List<ProductCardEntity> listOfProducts;
  final List<OccasionEntity> occasions;
}
