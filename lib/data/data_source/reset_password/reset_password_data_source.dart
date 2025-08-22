import '../../../api/client/api_result.dart';
import '../../../domain/entities/reset_password/request/reset_password_request.dart';
import '../../../domain/entities/reset_password/response/reset_password_response.dart';

abstract interface class ResetPasswordDataSource {
  Future<Result<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  );
}
