import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/address/remote_data_source/address_remote_data_source.dart';
import 'package:flowery_app/data/repositories/address/address_repository_impl.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_repository_impl_test.mocks.dart';

@GenerateMocks([AddressRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockAddressRemoteDataSource mockAddressRemoteDataSource;
  late final AddressRepositoryImpl addressRepositoryImpl;

  setUpAll(() {
    mockAddressRemoteDataSource = MockAddressRemoteDataSource();
    addressRepositoryImpl = AddressRepositoryImpl(mockAddressRemoteDataSource);
    provideDummy<Result<List<AddressEntity>?>>(
      Success<List<AddressEntity>?>([]),
    );
  });

  test(
    'when call removeAddress it should be called successfully from AddressRemoteDataSource',
    () async {
      // Arrange
      const testAddressId = "addr_123";
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);

      when(
        mockAddressRemoteDataSource.removeAddress(
          addressId: anyNamed("addressId"),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await addressRepositoryImpl.removeAddress(
        addressId: testAddressId,
      );
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(
        mockAddressRemoteDataSource.removeAddress(addressId: testAddressId),
      ).called(1);
    },
  );
  test(
    'when call addAddress it should return Success<List<AddressEntity>> from repository',
    () async {
      // Arrange
      final addAddressRequest = AddAddressRequestEntity(
        city: 'Cairo',
        street: '123 Main St',
        username: 'John Doe',
        phone: '1234567890',
        lat: '30.0444',
        long: '31.2357',
      );

      final List<AddressEntity> expectedEntities = [
        AddressEntity(
          username: 'John Doe',
          phone: '1234567890',
          city: 'Cairo',
          street: '123 Main St',
          lat: '30.0444',
          long: '31.2357',
          id: 'addr_123',
        ),
      ];

      final expectedResult = Success<List<AddressEntity>>(expectedEntities);

      provideDummy<Result<List<AddressEntity>>>(expectedResult);

      when(
        mockAddressRemoteDataSource.addAddress(addAddressRequest),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await addressRepositoryImpl.addAddress(addAddressRequest);

      // Assert
      verify(
        mockAddressRemoteDataSource.addAddress(addAddressRequest),
      ).called(1);

      expect(result, isA<Success<List<AddressEntity>?>>());

      final successResult = result as Success<List<AddressEntity>?>;
      expect(successResult.data, isNotNull);
      expect(successResult.data?.length, expectedEntities.length);
      expect(
        successResult.data?.map((e) => e.username),
        expectedEntities.map((e) => e.username),
      );
    },
  );
}
