import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/repositories/address/address_repository.dart';
import 'package:flowery_app/domain/use_cases/address/add_address_use_case.dart';
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
  late final GetAddAddressUseCase getAddAddressUseCase;

  setUpAll(() {
    mockAddressRepository = MockAddressRepository();
    removeAddressUseCase = RemoveAddressUseCase(mockAddressRepository);
    getAddAddressUseCase = GetAddAddressUseCase(mockAddressRepository);
    provideDummy<Result<List<AddressEntity>?>>(
      Success<List<AddressEntity>?>([]),
    );
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

  test(
    'when call invoke for addAddress it should be called successfully from AddressRepository',
    () async {
      // Arrange
      final request = AddAddressRequestEntity(
        city: 'Cairo',
        street: '123 Main St',
        username: 'John Doe',
        phone: '1234567890',
        lat: '30.0444',
        long: '31.2357',
      );

      final expectedEntities = [
        AddressEntity(
          id: 'addr_123',
          city: 'Cairo',
          street: '123 Main St',
          username: 'John Doe',
          phone: '1234567890',
          lat: '30.0444',
          long: '31.2357',
        ),
      ];

      final expectedResult = Success<List<AddressEntity>>(expectedEntities);
      provideDummy<Result<List<AddressEntity>>>(expectedResult);

      when(
        mockAddressRepository.addAddress(request),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await getAddAddressUseCase.execute(request);

      // Assert
      verify(mockAddressRepository.addAddress(request)).called(1);

      expect(result, isA<Success<List<AddressEntity>?>>());
      final success = result as Success<List<AddressEntity>?>;
      expect(success.data?.length, expectedEntities.length);
      expect(success.data?.first.username, equals('John Doe'));
    },
  );
}
