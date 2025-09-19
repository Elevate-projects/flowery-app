import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/edit_profile/edit_profile_data_source_impl.dart';
import 'package:flowery_app/api/models/address/address_model.dart';
import 'package:flowery_app/api/models/user_data/user_data_model.dart';
import 'package:flowery_app/api/responses/edit_profile_response/edit_profile_response.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'when call editUserProfile form apiClient and returns UserDataEntity',
    () async {
      //Arrange
      final mockApiClient = MockApiClient();
      final mockConnectivity = MockConnectivity();
      ConnectionManager.connectivity = mockConnectivity;
      final editProfileDataSourceImpl = EditProfileDataSourceImpl(
        mockApiClient,
      );
      final expectedUserData = UserDataModel(
        id: "1",
        email: "sadany@gmail.com",
        phone: "01155027741",
        firstName: "omar",
        lastName: "elsadany",
        gender: "male",
        photo: "profilePic",
        addresses: [
          AddressModel(
            street: "123 Nile Street",
            phone: "+201234567890",
            city: "Cairo",
            lat: "30.0444",
            long: "31.2357",
            username: "ahmed_tarek",
            id: "addr_001",
          ),
          AddressModel(
            street: "45 King Fahd Road",
            phone: "+966501234567",
            city: "Riyadh",
            lat: "24.7136",
            long: "46.6753",
            username: "sara_khaled",
            id: "addr_002",
          ),
        ],
        wishlist: ["item1", "item2"],
        createdAt: "2025-01-01",
        role: "user",
      );
      final editProfileRequestEntity = EditProfileRequestEntity(
        firstName: "omar",
        lastName: "elsadany",
        email: "sadany@gmail.com",
        phone: "01155027741",
      );

      final editProfileResponse = EditProfileResponse(
        message: "success",
        userData: expectedUserData,
      );
      final expectedUserDataEntity = Success(
        expectedUserData.toUserDataEntity(),
      );
      provideDummy<Result<UserDataEntity>>(expectedUserDataEntity);
      when(
        mockConnectivity.checkConnectivity(),
      ).thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(
        mockApiClient.editUserProfile(
          token: anyNamed("token"),
          request: anyNamed("request"),
        ),
      ).thenAnswer((_) async => editProfileResponse);

      //Act
      final result = await editProfileDataSourceImpl.editProfile(editProfileRequestEntity);
      final successResult = result as Success<UserDataEntity?>;
      //Assert
      expect(result, isA<Success<UserDataEntity?>>());
      verify(mockApiClient.editUserProfile(token: anyNamed("token"), request: anyNamed("request"))).called(1);
      expect(expectedUserDataEntity.data.firstName,equals(successResult.data?.firstName));
      expect(expectedUserDataEntity.data.lastName,equals(successResult.data?.lastName));
      expect(expectedUserDataEntity.data.email,equals(successResult.data?.email));
      expect(expectedUserDataEntity.data.phone,equals(successResult.data?.phone));
    },
  );
}
