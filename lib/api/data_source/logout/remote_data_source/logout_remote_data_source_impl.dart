import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/logout/remote_data_source/logout_remote_data_source.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRemoteDataSource)
class LogoutRemoteDataSourceImpl implements LogoutRemoteDataSource {
  final ApiClient _apiClient;
  const LogoutRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<void>> logout() async {
    return executeApi(() async {
      return await _apiClient.logout(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
      );
    });
  }
}
