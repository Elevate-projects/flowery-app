import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/register_request_mapper.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/data/data_source/register/remote_data_source/register_remote_data_source.dart';
import 'package:flowery_app/domain/entities/request/register_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';
@Injectable(as:RegisterRemoteDataSource )
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
final ApiClient _apiClient;
final SecureStorage _secureStorage;
RegisterRemoteDataSourceImpl(this._apiClient,this._secureStorage);

  @override
  Future<Result<UserDataEntity?>> register({required RegisterRequestEntity request}) {
    return executeApi(()async {
      final response = await _apiClient.register(request: RegisterRequestMapper.toRegisterRequest(entity: request));
      await _secureStorage.saveUserToken(token: response.token);
      FloweryMethodHelper.currentUserToken = response.token; 
      final userData= response.userRegisterModel?.toUserDataEntity();
      FloweryMethodHelper.userData = userData;
      return userData;
    },);
  }
}