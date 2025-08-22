import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

abstract class RegisterRepository {
  Future<Result<UserDataEntity?>> register({required RegisterRequest request});
}