import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/cart/remote_data_source_get_logged_user/remote_data_source_get_logged_user.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RemoteDataSourceGetLoggedUser)
class RemoteDataSourceGetLoggedUserImp implements RemoteDataSourceGetLoggedUser {
  final ApiClient _apiClient;

  RemoteDataSourceGetLoggedUserImp(this._apiClient);

  @override
  Future<Result<GetLoggedUserCartEntity>> getLoggedUserCart(String token) {
    return executeApi(() async {
      final result = await _apiClient.getLoggedUserCart(
        token: "Bearer $token",
      );
      return result.toEntity();
    },);
  }
}

