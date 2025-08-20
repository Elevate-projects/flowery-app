import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/splash/remote_data_source/splash_remote_data_source.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SplashRemoteDataSource)
class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final ApiClient _apiClient;
  const SplashRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<UserDataEntity?>> getUserData() async {
    return executeApi(() async {
      var response = await _apiClient.getUserData(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
      );
      var userData = response.user?.toUserDataEntity();
      return userData;
    });
  }
}
