import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/profile_reset_password/profile_reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';

abstract class ProfileResetPasswordDataSource {
  Future<Result<ProfileResetPasswordResponseEntity>> resetPassword({
    required ProfileResetPasswordRequestEntity entity,
  });
}
