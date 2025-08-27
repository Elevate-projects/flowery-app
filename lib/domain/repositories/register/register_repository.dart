import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/request/register_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

abstract class RegisterRepository {
  Future<Result<UserDataEntity?>> register({required RegisterRequestEntity request});
}