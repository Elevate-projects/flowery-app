
import '../../../../data/data_source/cart/remote_data_source/cart_remote_data_source.dart';
import '../../../../domain/entities/cart/cart_entities.dart';
import '../../../client/api_client.dart';
import '../../../client/api_result.dart';
 class CartRemoteDataSourceImp implements CartRemoteDataSource {

   final ApiClient _apiClient;
   const CartRemoteDataSourceImp(this._apiClient);

  @override
  Future<Result<ProductEntity>> cartPage({required request, required String token})async {
    return await executeApi(()async {
      final result = await _apiClient.cartPage(
        request: request,
        token: token,
      );
     // return result.cart;
    },);
  }
 }