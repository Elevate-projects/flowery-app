import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/add_to_cart/remote_data_source/add_to_cart_remote_data_source.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddToCartRemoteDataSource)
class AddToCartRemoteDataSourceImpl implements AddToCartRemoteDataSource {
  final ApiClient _apiClient;
  const AddToCartRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<void>> addProductToCart({
    required AddToCartRequestEntity request,
  }) async {
    return executeApi(() async {
      return await _apiClient.addProductToCart(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
        request: RequestMapper.toAddToCartRequestModel(
          addToCartRequestEntity: request,
        ),
      );
    });
  }
}
