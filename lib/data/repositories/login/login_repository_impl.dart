import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/login/remote_data_source/login_remote_data_source.dart';
import 'package:flowery_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/login/login_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  @factoryMethod
  const LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Result<UserDataEntity?>> login({
    required LoginRequestEntity request,
  }) async {
    return await loginRemoteDataSource.login(request: request);
  }
}
