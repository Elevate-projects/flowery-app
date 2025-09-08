 import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';

abstract interface class SearchDataSource{
  Future<Result<ProductsResponseEntity>>getProductBySearch(String productId );
}