import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/register/register_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final RegisterRepository _registerRepository;
  RegisterUseCase(this._registerRepository);
  Future<Result<UserDataEntity?>> invoke({
    required RegisterRequestEntity request,
  }) async {
    return await _registerRepository.register(request: request);
  }
}
