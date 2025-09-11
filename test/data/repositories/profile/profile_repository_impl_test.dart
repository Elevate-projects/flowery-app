import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/profile/remote_data_source/profile_remote_data_source.dart';
import 'package:flowery_app/data/repositories/profile/profile_repository_impl.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_impl_test.mocks.dart';

@GenerateMocks([ProfileRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call fetchUserData it should be called successfully from ProfileRemoteDataSource and return UserDataEntity',
    () async {
      // Arrange
      final mockedProfileRemoteDataSource = MockProfileRemoteDataSource();
      final profileRepositoryImpl = ProfileRepositoryImpl(
        mockedProfileRemoteDataSource,
      );
      final userDataEntity = UserDataEntity(
        id: "1",
        email: "ahmed@gmail.com",
        phone: "01116811741",
        firstName: "ahmed",
        lastName: "tarek",
        gender: "male",
        photo: "profilePic",
        addresses: [
          AddressEntity(
            street: "123 Nile Street",
            phone: "+201234567890",
            city: "Cairo",
            lat: "30.0444",
            long: "31.2357",
            username: "ahmed_tarek",
            id: "addr_001",
          ),
          AddressEntity(
            street: "45 King Fahd Road",
            phone: "+966501234567",
            city: "Riyadh",
            lat: "24.7136",
            long: "46.6753",
            username: "sara_khaled",
            id: "addr_002",
          ),
        ],
        wishlist: const ["item1", "item2"],
        role: "developer",
        passwordResetCode: "password code",
      );
      final expectedUserDataEntityResult = Success(userDataEntity);
      provideDummy<Result<UserDataEntity?>>(expectedUserDataEntityResult);
      when(
        mockedProfileRemoteDataSource.fetchUserData(),
      ).thenAnswer((_) async => expectedUserDataEntityResult);

      // Act
      final result = await profileRepositoryImpl.fetchUserData();
      final successResult = result as Success<UserDataEntity?>;

      // Assert
      verify(mockedProfileRemoteDataSource.fetchUserData()).called(1);
      expect(result, isA<Success<UserDataEntity?>>());
      expect(userDataEntity.id, equals(successResult.data?.id));
      expect(userDataEntity.photo, equals(successResult.data?.photo));
      expect(userDataEntity.phone, equals(successResult.data?.phone));
      expect(userDataEntity.email, equals(successResult.data?.email));
      expect(userDataEntity.role, equals(successResult.data?.role));
      expect(userDataEntity.gender, equals(successResult.data?.gender));
      expect(
        userDataEntity.wishlist?.elementAt(0),
        equals(successResult.data?.wishlist?.elementAt(0)),
      );
      expect(
        userDataEntity.addresses?.elementAt(0),
        equals(successResult.data?.addresses?.elementAt(0)),
      );
      expect(
        userDataEntity.passwordResetCode,
        equals(successResult.data?.passwordResetCode),
      );
    },
  );
}
