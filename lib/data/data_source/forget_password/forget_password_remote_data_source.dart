 import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
 import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';

    abstract interface class ForgetPasswordRemoteDataSource {
  Future<Result<ForgetPasswordEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  );
}
