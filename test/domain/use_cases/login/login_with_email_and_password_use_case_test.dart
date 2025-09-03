import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/login/login_repository.dart';
import 'package:flowery_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_with_email_and_password_use_case_test.mocks.dart';

@GenerateMocks([LoginRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call invoke it should be called successfully from LoginRepository and return UserDataEntity',
    () async {
      //Arrange
      final mockedLoginRepository = MockLoginRepository();
      final loginUseCase = LoginWithEmailAndPasswordUseCase(
        mockedLoginRepository,
      );
      final request = LoginRequestEntity(
        email: "ahmed@gmail.com",
        password: "Ahmed\$123",
      );
      final userDataEntity = UserDataEntity(
        id: "1",
        email: "ahmed@gmail.com",
        phone: "01116811741",
        firstName: "ahmed",
        lastName: "tarek",
        gender: "male",
        photo: "profilePic",
        addresses: const ["address1", "address2"],
        wishlist: const ["item1", "item2"],
        role: "developer",
      );
      final expectedUserDataEntityResult = Success(userDataEntity);
      provideDummy<Result<UserDataEntity?>>(expectedUserDataEntityResult);
      when(
        loginUseCase.invoke(request: request),
      ).thenAnswer((_) async => expectedUserDataEntityResult);

      // Act
      final result = await loginUseCase.invoke(request: request);
      final successResult = result as Success<UserDataEntity?>;

      // Assert
      verify(mockedLoginRepository.login(request: request)).called(1);
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
