import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/resend_code/resend_code_data_source.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flowery_app/domain/repositories/resend_code/resend_code.dart';
import 'package:injectable/injectable.dart';



@Injectable(as: ResendCodeRepository)
class ResendCodeRepositoryImpl implements ResendCodeRepository {
  final ResendCodeDataSource _resendCodeDataSource;

  ResendCodeRepositoryImpl(this._resendCodeDataSource);

  @override
  Future<Result<ResendCodeResponseEntity>> resendCode(
    ResendCodeRequestEntity request,
  ) {
    return _resendCodeDataSource.resendCode(request);
  }
}
