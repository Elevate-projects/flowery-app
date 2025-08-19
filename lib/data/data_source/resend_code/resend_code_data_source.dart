import '../../../api/client/api_result.dart';
import '../../../domain/entities/resend_code/request/resend_code_request.dart';
import '../../../domain/entities/resend_code/response/resend_code_response.dart';

abstract interface class ResendCodeDataSource {
  Future<Result<ResendCodeResponseEntity>> resendCode(
    ResendCodeRequestEntity request,
  );
}
