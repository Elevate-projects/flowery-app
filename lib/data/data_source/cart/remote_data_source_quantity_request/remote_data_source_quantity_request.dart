import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';
abstract class RemoteDataSourceQuantityRequest{
  Future<Result<QuantityEntity>> updateCartQuantity(String productId, String token, int quantity);
}