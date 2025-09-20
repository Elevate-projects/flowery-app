import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/forget_password/forget_password_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';

abstract interface class ForgetPasswordRemoteDataSource {
  Future<Result<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  );
}
