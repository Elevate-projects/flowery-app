import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/register/remote_data_source/register_remote_data_source.dart';
import 'package:flowery_app/data/repositories/register/register_repository_impl.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/entities/requests/register_request/register_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_repository_impl_test.mocks.dart';

@GenerateMocks([RegisterRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    "when call register successfully from registerRemoteDataSource it should return UserDataEntity",
    () async {
      //Arrange
      final mockRegisterRemoteDataSource = MockRegisterRemoteDataSource();
      final registerRepository = RegisterRepositoryImpl(
        mockRegisterRemoteDataSource,
      );
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
        role: "user",
      );
      final expectedResult = Success(userDataEntity);
      provideDummy<Result<UserDataEntity?>>(expectedResult);
      when(
        mockRegisterRemoteDataSource.register(request: registerRequestEntity),
      ).thenAnswer((_) async => expectedResult);
      //Act
      final result = await registerRepository.register(
        request: registerRequestEntity,
      );
      final successResult = result as Success<UserDataEntity?>;
      //Assert
      verify(
        mockRegisterRemoteDataSource.register(request: registerRequestEntity),
      ).called(1);
      expect(result, isA<Success<UserDataEntity?>>());
      expect(userDataEntity.id, equals(successResult.data?.id));
      expect(userDataEntity.email, equals(successResult.data?.email));
      expect(userDataEntity.phone, equals(successResult.data?.phone));
      expect(userDataEntity.firstName, equals(successResult.data?.firstName));
      expect(userDataEntity.lastName, equals(successResult.data?.lastName));
      expect(userDataEntity.gender, equals(successResult.data?.gender));
      expect(userDataEntity.photo, equals(successResult.data?.photo));
      expect(
        userDataEntity.addresses?.elementAt(0).username,
        equals(successResult.data?.addresses?.elementAt(0).username),
      );
      expect(
        userDataEntity.wishlist?.elementAt(0),
        equals(successResult.data?.wishlist?.elementAt(0)),
      );
      expect(userDataEntity.role, equals(successResult.data?.role));
    },
  );
}
