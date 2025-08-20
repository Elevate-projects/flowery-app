import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/splash/remote_data_source/splash_remote_data_source.dart';
import 'package:flowery_app/data/repositories/splash/splash_repository_impl.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_repository_impl_test.mocks.dart';

@GenerateMocks([SplashRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getUserData it should be called successfully from SplashRemoteDataSource and return UserDataEntity',
    () async {
      // Arrange
      final mockedSplashRemoteDataSource = MockSplashRemoteDataSource();
      final splashRepositoryImpl = SplashRepositoryImpl(
        mockedSplashRemoteDataSource,
      );
      final userDataEntity = UserDataEntity(
        id: "1",
        email: "ahmed@gmail.com",
        phone: "01116811741",
        firstName: "ahmed",
        lastName: "tarek",
        gender: "male",
        photo: "profilePic",
        addresses: ["address1", "address2"],
        wishlist: ["item1", "item2"],
        role: "developer",
      );
      final expectedUserDataEntityResult = Success(userDataEntity);
      provideDummy<Result<UserDataEntity?>>(expectedUserDataEntityResult);
      when(
        mockedSplashRemoteDataSource.getUserData(),
      ).thenAnswer((_) async => expectedUserDataEntityResult);

      // Act
      final result = await splashRepositoryImpl.getUserData();
      final successResult = result as Success<UserDataEntity?>;

      // Assert
      verify(mockedSplashRemoteDataSource.getUserData()).called(1);
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
    },
  );
}
