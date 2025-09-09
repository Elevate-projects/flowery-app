import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/repositories/address/address_repository.dart';
import 'package:flowery_app/domain/use_cases/address/remove_address_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remove_address_use_case_test.mocks.dart';

@GenerateMocks([AddressRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockAddressRepository mockAddressRepository;
  late final RemoveAddressUseCase removeAddressUseCase;

  setUpAll(() {
    mockAddressRepository = MockAddressRepository();
    removeAddressUseCase = RemoveAddressUseCase(mockAddressRepository);
  });

  test(
    'when call invoke it should be called successfully from AddressRepository',
    () async {
      // Arrange
      const testAddressId = "addr_123";
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);

      when(
        mockAddressRepository.removeAddress(addressId: anyNamed("addressId")),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await removeAddressUseCase.invoke(
        addressId: testAddressId,
      );
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(
        mockAddressRepository.removeAddress(addressId: testAddressId),
      ).called(1);
    },
  );
}
