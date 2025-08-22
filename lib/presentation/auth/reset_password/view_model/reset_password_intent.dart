import '../../../../domain/entities/reset_password/request/reset_password_request.dart';

sealed class ResetPasswordIntent {}

class OnResetPasswordIntent extends ResetPasswordIntent {
  ResetPasswordRequestEntity request;

  OnResetPasswordIntent({required this.request});
}
