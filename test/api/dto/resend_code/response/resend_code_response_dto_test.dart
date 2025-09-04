
import 'package:flowery_app/api/mapper/mapper.dart';
import 'package:flowery_app/api/responses/resend_code/resend_code_response_dto.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toEntity with null values it should return null values', () {
    ResendCodeResponseDto dto = ResendCodeResponseDto(
      message: null,
      info: null,
    );
    ResendCodeResponseEntity entity = Mapper.resendCodeToEntity(dto);
    expect(entity.message, isNull);
  });
  test(
    'when call toEntity with non-null values it should return right values',
    () {
      ResendCodeResponseDto dto = ResendCodeResponseDto(
        message: 'Verification code sent successfully',
        info: 'Please check your email for the verification code.',
      );
      ResendCodeResponseEntity entity = Mapper.resendCodeToEntity(dto);
      expect(entity.message, equals(dto.message));
      expect(entity.info, equals(dto.info));
    },
  );
}
