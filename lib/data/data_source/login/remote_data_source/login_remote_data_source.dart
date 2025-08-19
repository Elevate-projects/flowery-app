import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/requests/login_request/login_request.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

abstract class LoginRemoteDataSource {
  Future<Result<UserDataEntity?>> login({required LoginRequest request});
}
