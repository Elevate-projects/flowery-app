import 'package:injectable/injectable.dart';

import '../../../api/client/api_result.dart';
import '../../entities/resend_code/request/resend_code_request.dart';
import '../../entities/resend_code/response/resend_code_response.dart';
import '../../repositories/resend_code/resend_code.dart';

@injectable
class GetResendCodeUsecase {
  ResendCodeRepository _resendCodeRepository;

  GetResendCodeUsecase(this._resendCodeRepository);

  Future<Result<ResendCodeResponseEntity>> execute(
    ResendCodeRequestEntity request,
  ) {
    return _resendCodeRepository.resendCode(request);
  }
}
