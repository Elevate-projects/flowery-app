import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/api/requests/verification/verify_request_dto.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toDto with null values it should return null values', () {
    VerifyRequsetEntity entity = VerifyRequsetEntity(resetCode: null);
    VerifyRequestDto dto = RequestMapper.verifyToDto(entity);
    expect(dto.resetCode, isNull);
  });
  test(
    'when call toDto with non-null values it should return right values',
    () {
      VerifyRequsetEntity entity = VerifyRequsetEntity(resetCode: '123456');
      VerifyRequestDto dto = RequestMapper.verifyToDto(entity);
      expect(dto.resetCode, equals(entity.resetCode));
    },
  );
}
