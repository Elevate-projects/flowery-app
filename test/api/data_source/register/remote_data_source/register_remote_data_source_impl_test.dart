import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/register/remote_data_source/register_remote_data_source_impl.dart';
import 'package:flowery_app/api/models/register/user_register_model.dart';
import 'package:flowery_app/api/responses/register_response/register_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/domain/entities/request/register_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient,SecureStorage,Connectivity])
void main(){
TestWidgetsFlutterBinding.ensureInitialized();
test('when call register from apiClient and return a UserDataEntity',
()async{
// Arrange
 final mockApiClient = MockApiClient();
 final mockSecureStorage = MockSecureStorage();
 final mockConnectivity = MockConnectivity();
 ConnectionManager.connectivity= mockConnectivity;
 final registerRemoteDataSource =RegisterRemoteDataSourceImpl(mockApiClient, mockSecureStorage);
 final expectedUserDataModel = UserRegisterModel(
        id: "1",
        email: "sadany@gmail.com",
        phone: "01155027741",
        firstName: "omar",
        lastName: "elsadany",
        gender: "male",
        photo: "profilePic",
        addresses: ["address1", "address2"],
        wishlist: ["item1", "item2"],
        createdAt: "2025-01-01",
        role: "user",
      );

  final registerRequestEntity = RegisterRequestEntity(
    email: "sadany@gmail.com",
    firstName: "omar",
    lastName: "elsadany",
    password: "password123",
    rePassword: "password123",
    phone: "01155027741",
    gender: "male",
  );

  final expectedRegisterResponse = RegisterResponse(
    message: "success",
    token: "mocked_token",
    userRegisterModel: expectedUserDataModel
  );

  final expectedUserDataEntityResult =Success(expectedUserDataModel.toUserDataEntity());
  provideDummy<Result<UserDataEntity>>(expectedUserDataEntityResult);
  when(mockConnectivity.checkConnectivity()).thenAnswer((_) async=>[ConnectivityResult.wifi]);
  when(mockApiClient.register(request:anyNamed("request"))).thenAnswer((_)async =>expectedRegisterResponse);

  //Act 
  final result = await registerRemoteDataSource.register(request: registerRequestEntity);
  final successResult = result as Success<UserDataEntity?>;

  //Assert
  expect(result, isA<Success<UserDataEntity?>>());
  verify(mockApiClient.register(request: anyNamed("request"))).called(1);
  expect(expectedUserDataEntityResult.data.userId, equals(successResult.data?.userId));
  expect(expectedUserDataEntityResult.data.email, equals(successResult.data?.email));
  expect(expectedUserDataEntityResult.data.phone, equals(successResult.data?.phone));
  expect(expectedUserDataEntityResult.data.firstName, equals(successResult.data?.firstName));
  expect(expectedUserDataEntityResult.data.lastName, equals(successResult.data?.lastName));
  expect(expectedUserDataEntityResult.data.gender, equals(successResult.data?.gender));
  expect(expectedUserDataEntityResult.data.photo, equals(successResult.data?.photo));
  expect(expectedUserDataEntityResult.data.addresses, equals(successResult.data?.addresses));
  expect(expectedUserDataEntityResult.data.wishlist, equals(successResult.data?.wishlist));
  expect(expectedUserDataEntityResult.data.createdAt, equals(successResult.data?.createdAt));
  expect(expectedUserDataEntityResult.data.role, equals(successResult.data?.role));
});
}