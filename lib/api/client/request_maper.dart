import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/requests/login_request/login_request_entity.dart';

abstract class RequestMapper {
  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }

  static ForgetPasswordRequestDto toForgetPasswordRequestModel({
    required ForgetPasswordRequestEntity ForgetPasswordRequestEntity,
}){
    return ForgetPasswordRequestDto(
      email: ForgetPasswordRequestEntity.email,

    );
  }
}
