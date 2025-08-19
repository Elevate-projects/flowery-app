import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/login/remote_data_source/login_remote_data_source_impl.dart';
import 'package:flowery_app/api/models/user_data/user_data_model.dart';
import 'package:flowery_app/api/requests/login_request/login_request.dart';
import 'package:flowery_app/api/responses/login_response/login_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, SecureStorage, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call login it should be called successfully from apiClient and return UserDataEntity',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockSecureStorage = MockSecureStorage();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final loginRemoteDataSource = LoginRemoteDataSourceImpl(
        mockApiClient,
        mockSecureStorage,
      );
      final expectedUserDataModel = UserDataModel(
        id: "1",
        email: "ahmed@gmail.com",
        phone: "01116811741",
        firstName: "ahmed",
        lastName: "tarek",
        gender: "male",
        photo: "profilePic",
        addresses: ["address1", "address2"],
        wishlist: ["item1", "item2"],
        createdAt: "2020-01-01",
        role: "developer",
      );
      final LoginRequest request = LoginRequest(
        email: "ahmed@gmail.com",
        password: "Ahmed\$123",
      );
      final expectedLoginResponse = LoginResponse(
        token: "currentUserToken",
        message: "success",
        userData: expectedUserDataModel,
      );
      final expectedUserDataEntityResult = Success(
        expectedUserDataModel.toUserDataEntity(),
      );
      provideDummy<Result<UserDataEntity?>>(expectedUserDataEntityResult);
      when(
        mockedConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.login(request: request),
      ).thenAnswer((_) async => expectedLoginResponse);

      // Act
      final result = await loginRemoteDataSource.login(request: request);
      final successResult = result as Success<UserDataEntity?>;

      // Assert
      expect(result, isA<Success<UserDataEntity?>>());
      verify(mockApiClient.login(request: request)).called(1);
      expect(
        expectedUserDataEntityResult.data.id,
        equals(successResult.data?.id),
      );
      expect(
        expectedUserDataEntityResult.data.email,
        equals(successResult.data?.email),
      );
      expect(
        expectedUserDataEntityResult.data.phone,
        equals(successResult.data?.phone),
      );
      expect(
        expectedUserDataEntityResult.data.photo,
        equals(successResult.data?.photo),
      );
      expect(
        expectedUserDataEntityResult.data.addresses?.elementAt(0),
        equals(successResult.data?.addresses?.elementAt(0)),
      );
      expect(
        expectedUserDataEntityResult.data.wishlist?.elementAt(0),
        equals(successResult.data?.wishlist?.elementAt(0)),
      );
    },
  );
}
