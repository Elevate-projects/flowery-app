import 'package:flowery_app/api/dto/mapper/mapper.dart';
import 'package:flowery_app/api/dto/reset_password/response/reset_password_response_dto.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toEntity with null values it should return null values', () {
    ResetPasswordResponseDto dto = ResetPasswordResponseDto(
      message: null,
      code: null,
      token: null,
    );
    ResetPasswordResponseEntity entity = Mapper.resetPasswordToEntity(dto);
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
      ResetPasswordResponseEntity entity = Mapper.resetPasswordToEntity(dto);
      expect(entity.message, equals(dto.message));
      expect(entity.code, equals(dto.code));
      expect(entity.token, equals(dto.token));
    },
  );
}
