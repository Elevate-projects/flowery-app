import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

abstract class SplashRemoteDataSource {
  Future<Result<UserDataEntity?>> getUserData();
}
