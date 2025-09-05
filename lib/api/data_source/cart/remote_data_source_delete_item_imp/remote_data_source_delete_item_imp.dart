import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/cart/remote_data_source_delete_item/remote_data_source_delete_item.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: RemoteDataSourceDeleteItem)
class RemoteDataSourceDeleteItemImp implements RemoteDataSourceDeleteItem{
 final ApiClient apiClient;
  RemoteDataSourceDeleteItemImp({required this.apiClient});
  @override
  Future<Result<DeleteItemsEntity>> deleteCartItem(String productId, String token) {
    return executeApi(()async {
      final response = await apiClient.deleteCartQuantity(productId: productId,
        token: "Bearer $token",
      );
      return response.toEntity();
    },);
  }
}