import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/api/requests/reset_password/reset_password_request_dto.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toDto with null values it should return null values', () {
    ResetPasswordRequestEntity entity = ResetPasswordRequestEntity(
      email: null,
      newPassword: null,
    );
    ResetPasswordRequestDto dto = RequestMapper.resetPasswordToDto(entity);
    expect(dto.email, isNull);
  });
  test(
    'when call toDto with non-null values it should return right values',
    () {
      ResetPasswordRequestEntity entity = ResetPasswordRequestEntity(
        email: 'moaazhassan559@gmail.com',
        newPassword: 'MyNewPassword123',
      );
      ResetPasswordRequestDto dto = RequestMapper.resetPasswordToDto(entity);
      expect(dto.email, equals(entity.email));
      expect(dto.newPassword, equals(entity.newPassword));
    },
  );
}
