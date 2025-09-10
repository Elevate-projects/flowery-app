import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/address/remote_data_source/address_remote_data_source.dart';
import 'package:flowery_app/data/repositories/address/address_repository_impl.dart';
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
}
