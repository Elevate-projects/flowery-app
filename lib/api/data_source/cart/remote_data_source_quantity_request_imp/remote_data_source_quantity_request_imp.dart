import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/requests/cart_request/quintity_request.dart';
import 'package:flowery_app/data/data_source/cart/remote_data_source_quantity_request/remote_data_source_quantity_request.dart';
import 'package:flowery_app/domain/entities/cart/update_quantity/update_quantity.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: RemoteDataSourceQuantityRequest)
class RemoteDataSourceQuantityRequestImp implements RemoteDataSourceQuantityRequest{
  final ApiClient apiClient;
  RemoteDataSourceQuantityRequestImp(this.apiClient);
  @override
  Future<Result<QuantityEntity>> updateCartQuantity(String productId, String token, int quantity) {
    return executeApi(()async {
      final response = await apiClient.updateCartQuantity(
        productId: productId,
        token: "Bearer $token",
        request: QuantityRequest(quantity: quantity),
      );
      return response.toQuantityEntity();
    },);
  }
}