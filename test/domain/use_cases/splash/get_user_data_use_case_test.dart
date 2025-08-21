import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/splash/splash_repository.dart';
import 'package:flowery_app/domain/use_cases/splash/get_user_data_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_data_use_case_test.mocks.dart';

@GenerateMocks([SplashRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call invoke it should be called successfully from SplashRepository and return UserDataEntity',
    () async {
      //Arrange
      final mockedSplashRepository = MockSplashRepository();
      final getUserDataUseCase = GetUserDataUseCase(mockedSplashRepository);
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
        mockedSplashRepository.getUserData(),
      ).thenAnswer((_) async => expectedUserDataEntityResult);

      // Act
      final result = await getUserDataUseCase.invoke();
      final successResult = result as Success<UserDataEntity?>;

      // Assert
      verify(mockedSplashRepository.getUserData()).called(1);
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
