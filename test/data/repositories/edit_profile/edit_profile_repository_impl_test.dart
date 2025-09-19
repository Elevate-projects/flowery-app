import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/models/address/address_model.dart';
import 'package:flowery_app/api/models/user_data/user_data_model.dart';
import 'package:flowery_app/data/data_source/edit_profile/edit_profile_data_source.dart';
import 'package:flowery_app/data/repositories/edit_profile/edit_profile_repository_impl.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_repository_impl_test.mocks.dart';
@GenerateMocks([EditProfileDataSource])
void main(){
test('when call edit profile form editProfileDataSource and returns data', ()async{
   TestWidgetsFlutterBinding.ensureInitialized();
  //Arrange
  final mockEditProfileDataSource = MockEditProfileDataSource();
  final editProfileRepository = EditProfileRepositoryImpl(mockEditProfileDataSource);
   final editProfileRequestEntity = EditProfileRequestEntity(
        firstName: "omar",
        lastName: "elsadany",
        email: "sadany@gmail.com",
        phone: "01155027741",
      );
      final expectedUserData =  UserDataModel(
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
      final expectedsuccessUserDataEntity = Success(expectedUserData.toUserDataEntity());
      provideDummy<Result<UserDataEntity>>(expectedsuccessUserDataEntity);
      when(mockEditProfileDataSource.editProfile(editProfileRequestEntity)).thenAnswer((_)async => expectedsuccessUserDataEntity);
      //Act
      final result = await editProfileRepository.editProfile(editProfileRequestEntity);
      final successResult = result as Success<UserDataEntity>;
      //Assert
      expect(result, isA<Success<UserDataEntity>>());
      verify(mockEditProfileDataSource.editProfile(editProfileRequestEntity)).called(1);
      expect(expectedsuccessUserDataEntity.data.email,successResult.data.email);
      expect(expectedsuccessUserDataEntity.data.firstName,successResult.data.firstName);
      expect(expectedsuccessUserDataEntity.data.lastName,successResult.data.lastName);
      expect(expectedsuccessUserDataEntity.data.phone,successResult.data.phone);
});
}