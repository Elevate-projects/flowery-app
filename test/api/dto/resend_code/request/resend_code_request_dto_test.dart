import 'package:flowery_app/api/mapper/mapper.dart';
import 'package:flowery_app/api/requests/resend_code/resend_code_request_dto.dart';
import 'package:flowery_app/domain/entities/resend_code/request/resend_code_request.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toDto with null values it should return null values', () {
    ResendCodeRequestEntity entity = ResendCodeRequestEntity(email: null);
    ResendCodeRequestDto dto = Mapper.resendCodeToDto(entity);
    expect(dto.email, isNull);
  });
  test(
    'when call toDto with non-null values it should return right values',
    () {
      ResendCodeRequestEntity entity = ResendCodeRequestEntity(
        email: 'moaazhassan559@gmail.com',
      );
      ResendCodeRequestDto dto = Mapper.resendCodeToDto(entity);
      expect(dto.email, equals(entity.email));
    },
  );
}
