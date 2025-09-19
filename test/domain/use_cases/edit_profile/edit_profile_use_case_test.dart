import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/models/address/address_model.dart';
import 'package:flowery_app/api/models/user_data/user_data_model.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/repositories/edit_profile/edit_profile_repository.dart';
import 'package:flowery_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_use_case_test.mocks.dart';
@GenerateMocks([EditProfileRepository])
void main(){
   TestWidgetsFlutterBinding.ensureInitialized();
 test('when call edit profile from editProfileUseCase it should return userData', ()async {
  final mockEditProfileRepository = MockEditProfileRepository();
 final editProfileUseCase = EditProfileUseCase(mockEditProfileRepository);
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
      when(mockEditProfileRepository.editProfile(editProfileRequestEntity)).thenAnswer((_)async => expectedsuccessUserDataEntity);
      //Act
      final result = await editProfileUseCase.invoke(request: editProfileRequestEntity);
      final successResult = result as Success<UserDataEntity>;
      //Assert
      expect(result, isA<Success<UserDataEntity>>());
      verify(mockEditProfileRepository.editProfile(editProfileRequestEntity)).called(1);
      expect(expectedsuccessUserDataEntity.data.email,equals(successResult.data.email));
      expect(expectedsuccessUserDataEntity.data.firstName,equals(successResult.data.firstName));
      expect(expectedsuccessUserDataEntity.data.phone,equals(successResult.data.phone));
      expect(expectedsuccessUserDataEntity.data.lastName,equals(successResult.data.lastName));
 });
}