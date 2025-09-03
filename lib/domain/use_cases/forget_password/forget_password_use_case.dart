import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/forget_password/forget_password_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/repositories/forget_password/forget_password_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordUseCase {
  final ForgetPasswordRepo _forgetPasswordRepo;
  ForgetPasswordUseCase(this._forgetPasswordRepo);
  Future<Result<ForgetPasswordEntity>> call(
    ForgetPasswordRequestEntity request,
  ) {
    return _forgetPasswordRepo.forgetPassword(request);
  }
}
