import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/responses/forget_password_response/forget_password_response.dart';
import 'package:flowery_app/data/data_source/forget_password/forget_password_remote_data_source.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ForgetPasswordRemoteDataSource)
class ForgetPasswordRemoteDataSourceImpl extends ForgetPasswordRemoteDataSource {
  ApiClient _apiClient;

  ForgetPasswordRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<ForgetPasswordResponseEntity>> getForgetPassword(
    ForgetPasswordRequestEntity request,
  ) async {
    var res = await executeApi(
      () => _apiClient.forgetPassword(
        request: ForgetPasswordRequestDto.toDto(request),
      ),
    );
    switch (res) {
      case Success<ForgetPasswordResponseDto>():
        return Success(ForgetPasswordResponseDto.toEntity(res.data));
      case Failure<ForgetPasswordResponseDto>():
        return Failure(responseException: res.responseException);
    }
  }
}
