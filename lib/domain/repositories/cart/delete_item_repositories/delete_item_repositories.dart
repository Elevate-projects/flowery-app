import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';

abstract class RemoteDataSourceDeleteItemRepositories{
  Future<Result<DeleteItemsEntity>> deleteCartItem(String productId, String token,);
}