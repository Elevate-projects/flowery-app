import 'package:injectable/injectable.dart';

import '../../../api/client/api_result.dart';
import '../../../domain/entities/resend_code/request/resend_code_request.dart';
import '../../../domain/entities/resend_code/response/resend_code_response.dart';
import '../../../domain/repositories/resend_code/resend_code.dart';
import '../../data_source/resend_code/resend_code_data_source.dart';

@Injectable(as: ResendCodeRepository)
class ResendCodeRepositoryImpl implements ResendCodeRepository {
  ResendCodeDataSource _resendCodeDataSource;

  ResendCodeRepositoryImpl(this._resendCodeDataSource);

  @override
  Future<Result<ResendCodeResponseEntity>> resendCode(
    ResendCodeRequestEntity request,
  ) {
    return _resendCodeDataSource.resendCode(request);
  }
}
