import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

abstract interface class SearchDataSource {
  Future<Result<List<ProductCardEntity>>> searchProducts({
    required String search,
  });
}
