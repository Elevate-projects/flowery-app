import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';

abstract interface class ResetPasswordRepository {
  Future<Result<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  );
}
