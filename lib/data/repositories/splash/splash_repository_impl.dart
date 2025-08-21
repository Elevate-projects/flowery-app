import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/splash/remote_data_source/splash_remote_data_source.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/splash/splash_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SplashRepository)
class SplashRepositoryImpl implements SplashRepository {
  final SplashRemoteDataSource _splashRemoteDataSource;
  const SplashRepositoryImpl(this._splashRemoteDataSource);

  @override
  Future<Result<UserDataEntity?>> getUserData() async {
    return await _splashRemoteDataSource.getUserData();
  }
}
