import 'package:flowery_app/api/dto/mapper/mapper.dart';
import 'package:injectable/injectable.dart';

import '../../../data/data_source/reset_password/reset_password_data_source.dart';
import '../../../domain/entities/reset_password/request/reset_password_request.dart';
import '../../../domain/entities/reset_password/response/reset_password_response.dart';
import '../../client/api_client.dart';
import '../../client/api_result.dart';

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
        Mapper.resetPasswordToDto(request),
      );
      return Mapper.resetPasswordToEntity(res);
    });
  }
}
