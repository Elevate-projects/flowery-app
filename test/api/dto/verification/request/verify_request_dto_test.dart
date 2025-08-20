import 'package:flowery_app/api/dto/mapper/mapper.dart';
import 'package:flowery_app/api/dto/verification/request/verify_request_dto.dart';
import 'package:flowery_app/domain/entities/verification/request/verify_requset.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call toDto with null values it should return null values', () {
    VerifyRequsetEntity entity = VerifyRequsetEntity(resetCode: null);
    VerifyRequestDto dto = Mapper.verifyToDto(entity);
    expect(dto.resetCode, isNull);
  });
  test(
    'when call toDto with non-null values it should return right values',
    () {
      VerifyRequsetEntity entity = VerifyRequsetEntity(resetCode: '123456');
      VerifyRequestDto dto = Mapper.verifyToDto(entity);
      expect(dto.resetCode, equals(entity.resetCode));
    },
  );
}
