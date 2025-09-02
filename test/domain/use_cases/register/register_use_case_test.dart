import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/request/register_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/register/register_repository.dart';
import 'package:flowery_app/domain/use_cases/register/register_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_use_case_test.mocks.dart';

@GenerateMocks([RegisterRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    "when call register successfully from registerRepository it should return UserDataEntity",
    () async {
      //Arrange
      final mockRegisterRepository = MockRegisterRepository();
      final registerUseCase = RegisterUseCase(mockRegisterRepository);
      final registerRequestEntity = RegisterRequestEntity(
        email: "test@example.com",
        password: "password",
        rePassword: "password",
        firstName: "John",
        lastName: "Doe",
        phone: "1234567890",
        gender: "Male",
      );
      final userDataEntity = UserDataEntity(
        id: "1",
        email: "sadany@gmail.com",
        phone: "01155027741",
        firstName: "omar",
        lastName: "elsadany",
        gender: "male",
        photo: "profilePic",
        addresses: ["address1", "address2"],
        wishlist: ["item1", "item2"],
        role: "user",
      );
      final expectedResult = Success(userDataEntity);
      provideDummy<Result<UserDataEntity?>>(expectedResult);
      when(
        mockRegisterRepository.register(request: registerRequestEntity),
      ).thenAnswer((_) async => expectedResult);
      //Act
      final result = await registerUseCase.invoke(
        request: registerRequestEntity,
      );
      final successResult = result as Success<UserDataEntity?>;
      //Assert
      verify(
        mockRegisterRepository.register(request: registerRequestEntity),
      ).called(1);
      expect(result, isA<Success<UserDataEntity?>>());
      expect(userDataEntity.id, equals(successResult.data?.id));
      expect(userDataEntity.email, equals(successResult.data?.email));
      expect(userDataEntity.phone, equals(successResult.data?.phone));
      expect(userDataEntity.firstName, equals(successResult.data?.firstName));
      expect(userDataEntity.lastName, equals(successResult.data?.lastName));
      expect(userDataEntity.gender, equals(successResult.data?.gender));
      expect(userDataEntity.photo, equals(successResult.data?.photo));
      expect(userDataEntity.addresses, equals(successResult.data?.addresses));
      expect(
        userDataEntity.wishlist?.elementAt(0),
        equals(successResult.data?.wishlist?.elementAt(0)),
      );
      expect(userDataEntity.role, equals(successResult.data?.role));
    },
  );
}
