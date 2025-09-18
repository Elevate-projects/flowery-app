import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';
import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';

abstract class ResetPasswordRepository {
  Future<Result<ResetPasswordResponseEntity>> resetPassword({
    required ResetPasswordRequestEntity entity,
  });
}
