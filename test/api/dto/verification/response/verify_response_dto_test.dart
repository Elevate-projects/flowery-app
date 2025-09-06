import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/api/responses/verification/verify_response_dto.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toEntity with null values it should return null values', () {
    VerifyResponseDto dto = VerifyResponseDto(
      message: null,
      code: null,
      status: null,
    );
    VerifyResponseEntity entity = RequestMapper.verifyToEntity(dto);
    expect(entity.message, isNull);
    expect(entity.code, isNull);
    expect(entity.status, isNull);
  });
  test(
    'when call toEntity with non-null values it should return right values',
    () {
      VerifyResponseDto dto = VerifyResponseDto(
        status: 'success',
        message: 'Verification successful',
        code: 200,
      );
      VerifyResponseEntity entity = RequestMapper.verifyToEntity(dto);
      expect(entity.message, equals(dto.message));
      expect(entity.code, equals(dto.code));
      expect(entity.status, equals(dto.status));
    },
  );
}
