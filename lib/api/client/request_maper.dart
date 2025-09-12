import 'dart:io';

import 'package:flowery_app/api/requests/edit_profile_request/edit_profile_request.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_app/domain/entities/requests/register_request/register_request_entity.dart';

abstract class RequestMapper {
  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }

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

  static ForgetPasswordRequestDto toForgetPasswordRequestModel({
    required ForgetPasswordRequestEntity forgetPasswordRequestEntity,
  }) {
    return ForgetPasswordRequestDto(email: forgetPasswordRequestEntity.email);
  }

  static  EditProfileRequest toEditProfileRequestEntity({
    required  EditProfileRequestEntity entity,
  }) {
    return  EditProfileRequest(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
    );
  }
}
