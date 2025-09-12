import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flowery_app/domain/repositories/reset_password/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetResetPasswordUseCase {
  ResetPasswordRepository resetPasswordRepository;

  @factoryMethod
  GetResetPasswordUseCase(this.resetPasswordRepository);

  Future<Result<ResetPasswordResponseEntity>> execute(
    ResetPasswordRequestEntity request,
  ) {
    return resetPasswordRepository.resetPassword(request);
  }
}
