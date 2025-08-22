
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';

sealed class ForgetPasswordIntent {}

class OnConfirmEmailForgetPasswordClickIntent extends ForgetPasswordIntent {
  ForgetPasswordRequestEntity request;

  OnConfirmEmailForgetPasswordClickIntent({required this.request});
}
