import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/requests/login_request/login_request.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/login/login_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginWithEmailAndPasswordUseCase {
  final LoginRepository _loginRepository;
  @factoryMethod
  const LoginWithEmailAndPasswordUseCase(this._loginRepository);

  Future<Result<UserDataEntity?>> invoke({
    required LoginRequest request,
  }) async {
    return await _loginRepository.login(request: request);
  }
}
