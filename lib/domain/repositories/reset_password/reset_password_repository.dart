import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';

abstract class ResetPasswordRepository {
  Future<Result<void>> resetPassword({
    required ResetPasswordRequestEntity entity,
  });
}
