import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/api/responses/reset_password/reset_password_response_dto.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toEntity with null values it should return null values', () {
    ResetPasswordResponseDto dto = ResetPasswordResponseDto(
      message: null,
      code: null,
      token: null,
    );
    ResetPasswordResponseEntity entity = RequestMapper.resetPasswordToEntity(dto);
    expect(entity.message, isNull);
    expect(entity.code, isNull);
    expect(entity.token, isNull);
  });
  test(
    'when call toEntity with non-null values it should return right values',
    () {
      ResetPasswordResponseDto dto = ResetPasswordResponseDto(
        message: 'Password reset successfully',
        code: 200,
        token: 'newly_generated_token',
      );
      ResetPasswordResponseEntity entity = RequestMapper.resetPasswordToEntity(dto);
      expect(entity.message, equals(dto.message));
      expect(entity.code, equals(dto.code));
      expect(entity.token, equals(dto.token));
    },
  );
}
