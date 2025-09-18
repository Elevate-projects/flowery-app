import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/reset_password/reset_password_data_source.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordDataSource)
class ResetPasswordDataSourceImpl implements ResetPasswordDataSource {
  final ApiClient _apiClient;

  ResetPasswordDataSourceImpl(this._apiClient);

  @override
  Future<Result<ResetPasswordResponseEntity>> resetPassword({
    required ResetPasswordRequestEntity entity,
  }) async {
      return executeApi(() async {
      final response = await _apiClient.resetPassword(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
        entity: RequestMapper.toResetPasswordRequest(entity: entity),
      );
      final result = response.toResetPasswordResponseEntity();
      FloweryMethodHelper.currentUserToken = result.bearerToken;
      return result;
    });
    }
  }

