import 'package:flowery_app/api/requests/add_to_cart_request/add_to_cart_request_model.dart';
import 'package:flowery_app/api/requests/forget_password_request/forget_password_request.dart';
import 'package:flowery_app/api/requests/login_request/login_request_model.dart';
import 'package:flowery_app/api/requests/register_request/register_request.dart';
import 'package:flowery_app/api/requests/resend_code/resend_code_request_dto.dart';
import 'package:flowery_app/api/requests/reset_password/reset_password_request_dto.dart';
import 'package:flowery_app/api/requests/verification/verify_request_dto.dart';
import 'package:flowery_app/api/responses/resend_code/resend_code_response_dto.dart';
import 'package:flowery_app/api/responses/reset_password/reset_password_response_dto.dart';
import 'package:flowery_app/api/responses/verification/verify_response_dto.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';

abstract class RequestMapper {
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

  static LoginRequestModel toLoginRequestModel({
    required LoginRequestEntity loginRequestEntity,
  }) {
    return LoginRequestModel(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }

  static ForgetPasswordRequestDto toForgetPasswordRequestModel({
    required ForgetPasswordRequestEntity forgetPasswordRequestEntity,
  }) {
    return ForgetPasswordRequestDto(email: forgetPasswordRequestEntity.email);
  }

  static ResendCodeRequestDto resendCodeToDto(ResendCodeRequestEntity entity) {
    return ResendCodeRequestDto(email: entity.email);
  }

  static ResendCodeResponseEntity resendCodeToEntity(
    ResendCodeResponseDto dto,
  ) {
    return ResendCodeResponseEntity(message: dto.message, info: dto.info);
  }

  static VerifyRequestDto verifyToDto(VerifyRequestEntity entity) {
    return VerifyRequestDto(resetCode: entity.resetCode);
  }

  static VerifyResponseEntity verifyToEntity(VerifyResponseDto dto) {
    return VerifyResponseEntity(
      status: dto.status,
      message: dto.message,
      code: dto.code,
    );
  }

  static ResetPasswordRequestDto resetPasswordToDto(
    ResetPasswordRequestEntity entity,
  ) {
    return ResetPasswordRequestDto(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }

  static ResetPasswordResponseEntity resetPasswordToEntity(
    ResetPasswordResponseDto dto,
  ) {
    return ResetPasswordResponseEntity(
      message: dto.message,
      token: dto.token,
      code: dto.code,
    );
  }

  static AddToCartRequestModel toAddToCartRequestModel({
    required AddToCartRequestEntity addToCartRequestEntity,
  }) {
    return AddToCartRequestModel(
      productId: addToCartRequestEntity.productId,
      quantity: addToCartRequestEntity.quantity ?? 1,
    );
  }
}
