import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/profile_reset_password/profile_reset_password_data_source.dart';
import 'package:flowery_app/domain/entities/profile_reset_password/profile_reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileResetPasswordDataSource)
class ProfileResetPasswordDataSourceImpl implements ProfileResetPasswordDataSource {
  final ApiClient _apiClient;

  ProfileResetPasswordDataSourceImpl(this._apiClient);

  @override
  Future<Result<ProfileResetPasswordResponseEntity>> resetPassword({
    required ProfileResetPasswordRequestEntity entity,
  }) async {
      return executeApi(() async {
      final response = await _apiClient.profileResetPassword(
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
        entity: RequestMapper.toProfileResetPasswordRequest(entity: entity),
      );
      final result = response.toProfileResetPasswordResponseEntity();
      FloweryMethodHelper.currentUserToken = result.bearerToken;
      return result;
    });
    }
  }

