import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flowery_app/domain/repositories/resend_code/resend_code.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetResendCodeUseCase {
  final ResendCodeRepository _resendCodeRepository;

  GetResendCodeUseCase(this._resendCodeRepository);

  Future<Result<ResendCodeResponseEntity>> execute(
    ResendCodeRequestEntity request,
  ) {
    return _resendCodeRepository.resendCode(request);
  }
}
