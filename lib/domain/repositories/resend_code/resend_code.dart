import '../../../api/client/api_result.dart';
import '../../entities/resend_code/request/resend_code_request.dart';
import '../../entities/resend_code/response/resend_code_response.dart';

abstract interface class ResendCodeRepository {
  Future<Result<ResendCodeResponseEntity>> resendCode(
    ResendCodeRequestEntity request,
  );
}
