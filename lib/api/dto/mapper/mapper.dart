import '../../../domain/entities/resend_code/request/resend_code_request.dart';
import '../../../domain/entities/resend_code/response/resend_code_response.dart';
import '../../../domain/entities/reset_password/request/reset_password_request.dart';
import '../../../domain/entities/reset_password/response/reset_password_response.dart';
import '../../../domain/entities/verification/request/verify_requset.dart';
import '../../../domain/entities/verification/response/verify_response.dart';
import '../resend_code/request/resend_code_request_dto.dart';
import '../resend_code/response/resend_code_response_dto.dart';
import '../reset_password/request/reset_password_request_dto.dart';
import '../reset_password/response/reset_password_response_dto.dart';
import '../verification/request/verify_request_dto.dart';
import '../verification/response/verify_response_dto.dart';

class Mapper {
  static ResendCodeRequestDto resendCodeToDto(ResendCodeRequestEntity entity) {
    return ResendCodeRequestDto(email: entity.email);
  }

  static ResendCodeResponseEntity resendCodeToEntity(
    ResendCodeResponseDto dto,
  ) {
    return ResendCodeResponseEntity(message: dto.message, info: dto.info);
  }

  static VerifyRequestDto verifyToDto(VerifyRequsetEntity entity) {
    return VerifyRequestDto(resetCode: entity.resetCode);
  }

  static VerifyResponseEntity verifyToEntity(VerifyResponseDto dto) {
    return VerifyResponseEntity(
      status: dto.status,
      message: dto.message,
      code: dto.code,
    );
  }

  static ResetPasswordRequestDto resetPasswordToDto(ResetPasswordRequestEntity entity) {
    return ResetPasswordRequestDto(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }

  static ResetPasswordResponseEntity resetPasswordToEntity(ResetPasswordResponseDto dto) {
    return ResetPasswordResponseEntity(
      message: dto.message,
      token: dto.token,
      code: dto.code,
    );
  }
}
