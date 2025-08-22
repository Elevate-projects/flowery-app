import 'package:injectable/injectable.dart';

import '../../../api/client/api_result.dart';
import '../../entities/reset_password/request/reset_password_request.dart';
import '../../entities/reset_password/response/reset_password_response.dart';
import '../../repositories/reset_password/reset_password_repository.dart';

@injectable
class GetResetPasswordUsecase {
  ResetPasswordRepository resetPasswordRepository;

  @factoryMethod
  GetResetPasswordUsecase(this.resetPasswordRepository);

  Future<Result<ResetPasswordResponseEntity>> execute(
    ResetPasswordRequestEntity request,
  ) {
    return resetPasswordRepository.resetPassword(request);
  }
}
