import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/profile/remote_data_source/profile_remote_data_source_impl.dart';
import 'package:flowery_app/api/models/user_data/user_data_model.dart';
import 'package:flowery_app/api/responses/profile_response/profile_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call getUserData it should be called successfully from apiClient and return UserDataEntity',
    () async {
      // Arrange
      final mockApiClient = MockApiClient();
      final mockedConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockedConnectivity;
      final profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(
        mockApiClient,
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
      final expectedProfileResponse = ProfileResponse(
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
        mockApiClient.getUserData(token: anyNamed("token")),
      ).thenAnswer((_) async => expectedProfileResponse);

      // Act
      final result = await profileRemoteDataSourceImpl.fetchUserData();
      final successResult = result as Success<UserDataEntity?>;

      // Assert
      expect(result, isA<Success<UserDataEntity?>>());
      verify(mockApiClient.getUserData(token: anyNamed("token"))).called(1);
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
      expect(
        expectedUserDataEntityResult.data.passwordResetCode,
        equals(successResult.data?.passwordResetCode),
      );
    },
  );
}
