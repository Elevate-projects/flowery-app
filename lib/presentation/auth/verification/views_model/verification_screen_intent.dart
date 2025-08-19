import '../../../../domain/entities/resend_code/request/resend_code_request.dart';
import '../../../../domain/entities/verification/request/verify_requset.dart';

sealed class VerificationScreenIntent {}

class OnResendClickIntent extends VerificationScreenIntent {
  ResendCodeRequestEntity request;

  OnResendClickIntent({required this.request});
}

class OnVerificationIntent extends VerificationScreenIntent {
  VerifyRequsetEntity request;

  OnVerificationIntent({required this.request});
}
