import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordDataSource)
class ResetPasswordDataSourceImpl implements ResetPasswordDataSource {
  ApiClient apiClient;

  @factoryMethod
  ResetPasswordDataSourceImpl(this.apiClient);

  @override
  Future<Result<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) async {
    return executeApi(() async {
      var res = await apiClient.resetPassword(
        RequestMapper.resetPasswordToDto(request),
      );
      return RequestMapper.resetPasswordToEntity(res);
    });
  }
}
