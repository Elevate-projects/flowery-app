import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/domain/entities/request/register_request_entity.dart';

abstract class RegisterRequestMapper {
  static RegisterRequest toRegisterRequest({
    required RegisterRequestEntity entity,
  }) {
    return RegisterRequest(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      rePassword: entity.rePassword,
      phone: entity.phone,
      gender: entity.gender,
    );
  }
}
