
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
 import 'package:flowery_app/data/data_source/forget_password/forget_password_remote_data_source.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
 import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl implements ForgetPasswordRemoteDataSource {
 final ApiClient _apiClient;

  ForgetPasswordRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<ForgetPasswordEntity>> forgetPassword(ForgetPasswordRequestEntity request,)
  async {
    return await executeApi(()async {
      var response = await _apiClient.forgetPassword(
        request: RequestMapper.toForgetPasswordRequestModel(
            ForgetPasswordRequestEntity: request),
      );
      return response.toForgetPasswordEntity();
    });

    }

  }



