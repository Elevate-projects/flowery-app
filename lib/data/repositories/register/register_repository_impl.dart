import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/data/data_source/register/remote_data_source/register_remote_data_source.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/register/register_repository.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _remoteDataSource;
  RegisterRepositoryImpl(this._remoteDataSource);
  @override
  Future<Result<UserDataEntity?>> register({required RegisterRequest request}) {
    return _remoteDataSource.register(request: request);
  }

}
