import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';

sealed class VerificationScreenIntent {}

class OnResendClickIntent extends VerificationScreenIntent {
  ResendCodeRequestEntity request;

  OnResendClickIntent({required this.request});
}

class OnVerificationIntent extends VerificationScreenIntent {
  VerifyRequestEntity request;

  OnVerificationIntent({required this.request});
}

class OnStartTimer extends VerificationScreenIntent {}
