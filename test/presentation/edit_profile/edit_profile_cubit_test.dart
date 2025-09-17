import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flowery_app/domain/use_cases/edit_profile/upload_photo_use_case.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_intents.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../fake_form_state.dart';
import 'edit_profile_cubit_test.mocks.dart';

@GenerateMocks([EditProfileUseCase, UploadPhotoUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockEditProfileUseCase mockEditProfileUseCase;
  late MockUploadPhotoUseCase mockUploadPhotoUseCase;
  late EditProfileCubit editProfileCubit;
  late Result<UserDataEntity> expectedUserSuccessResult;
  late Failure<UserDataEntity> expectedUserFailureResult;
  late Result<UploadPhotoResponseEntity> expectedUploadPhotoSuccessResult;
  late Failure<UploadPhotoResponseEntity> expectedUploadPhotoFailureResult;
  late UserDataEntity userDataEntity;
  late UploadPhotoResponseEntity uploadPhotoResponseEntity;
  final expectedFilePath = File('path/to/photo.jpg');
  setUpAll(() {
    mockEditProfileUseCase = MockEditProfileUseCase();
    mockUploadPhotoUseCase = MockUploadPhotoUseCase();
    uploadPhotoResponseEntity = UploadPhotoResponseEntity(message: 'success');
    
    userDataEntity = UserDataEntity(
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
    expectedUserFailureResult = Failure(
      responseException: const ResponseException(message: "failed to register"),
    );
    expectedUploadPhotoFailureResult = Failure(
      responseException: const ResponseException(
        message: "failed to upload photo",
      ),
    );
    expectedUserSuccessResult = Success<UserDataEntity>(userDataEntity);
    expectedUploadPhotoSuccessResult = Success<UploadPhotoResponseEntity>(
      uploadPhotoResponseEntity,
    );
    provideDummy<Result<UserDataEntity>>(expectedUserSuccessResult);
    provideDummy<Result<UserDataEntity>>(expectedUserFailureResult);
    provideDummy<Result<UploadPhotoResponseEntity>>(
      expectedUploadPhotoSuccessResult,
    );
    provideDummy<Result<UploadPhotoResponseEntity>>(
      expectedUploadPhotoFailureResult,
    );
  });
  setUp(() {
    editProfileCubit = EditProfileCubit(
      mockEditProfileUseCase,
      mockUploadPhotoUseCase,
    );
    editProfileCubit.doIntent(intent: InitializedEditProfileIntent());
    editProfileCubit.editFormKey = FakeGlobalKey(FakeFormState());
  });
  group('EditProfileCubit', () {
    blocTest<EditProfileCubit, EditProfileState>(
      'emits [loading, success] when editprofile is successful',
      build: () {
        when(
          mockEditProfileUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedUserSuccessResult);
        return editProfileCubit;
      },
      act: (cubit) => [cubit.doIntent(intent: EditProfileWithDataIntent())],
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.editProfileState.isLoading,
          "loading",
          equals(true),
        ),
        isA<EditProfileState>()
            .having(
              (state) => state.editProfileState.isSuccess,
              "success",
              equals(true),
            )
            .having(
              (state) => FloweryMethodHelper.userData?.email,
              "check if userdata edited successfully and equals to the expected data",
              equals(
                (expectedUserSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.email,
              ),
            )
            .having(
              (state) => FloweryMethodHelper.userData?.firstName,
              "check if userdata edited successfully and equals to the expected data",
              equals(
                (expectedUserSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.firstName,
              ),
            )
            .having(
              (state) => FloweryMethodHelper.userData?.lastName,
              "check if userdata edited successfully and equals to the expected data",
              equals(
                (expectedUserSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.lastName,
              ),
            )
            .having(
              (state) => FloweryMethodHelper.userData?.phone,
              "check if userdata edited successfully and equals to the expected data",
              equals(
                (expectedUserSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.phone,
              ),
            ),
      ],
      verify: (_) => [
        verify(
          mockEditProfileUseCase.invoke(request: anyNamed("request")),
        ).called(1),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits [loading, failure] when editprofile is unsuccessful',
      build: () {
        when(
          mockEditProfileUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedUserFailureResult);
        return editProfileCubit;
      },
      act: (cubit) => [cubit.doIntent(intent: EditProfileWithDataIntent())],
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.editProfileState.isLoading,
          "loading",
          equals(true),
        ),
        isA<EditProfileState>()
            .having(
              (state) => state.editProfileState.isFailure,
              "failure",
              equals(true),
            )
            .having(
              (state) => state.editProfileState.error?.message,
              "response exception message",
              equals((expectedUserFailureResult).responseException.message),
            ),
      ],
      verify: (_) => [
        verify(
          mockEditProfileUseCase.invoke(request: anyNamed("request")),
        ).called(1),
      ],
    );

    blocTest<EditProfileCubit, EditProfileState>(
      'emits [loading, success] when uploadPhoto is successful',
      build: () {
        when(
          mockUploadPhotoUseCase.invoke(photoFile: anyNamed("photoFile")),
        ).thenAnswer((_) async => expectedUploadPhotoSuccessResult);
        return editProfileCubit;
      },
      act:(cubit) async {
  await cubit.testUploadPhoto(expectedFilePath);
},
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.uploadPhotoState.isLoading,
          "loading",
          equals(true),
        ),
        isA<EditProfileState>()
            .having(
              (state) => state.uploadPhotoState.isSuccess,
              "success",
              equals(true),
            ).
            having((state) => state.uploadPhotoState.data, "uploaded photo file", equals(expectedFilePath))
      ],
      verify: (_) => [
        verify(
          mockUploadPhotoUseCase.invoke(photoFile: expectedFilePath),
        ).called(1),
      ],
    );

     blocTest<EditProfileCubit, EditProfileState>(
      'emits [loading, failure] when uploadPhoto is unsuccessful',
      build: () {
        when(
          mockUploadPhotoUseCase.invoke(photoFile: anyNamed("photoFile")),
        ).thenAnswer((_) async => expectedUploadPhotoFailureResult);
        return editProfileCubit;
      },
      act:(cubit) async {
  await cubit.testUploadPhoto(expectedFilePath);
},
      expect: () => [
        isA<EditProfileState>().having(
          (state) => state.uploadPhotoState.isLoading,
          "loading",
          equals(true),
        ),
        isA<EditProfileState>()
            .having(
              (state) => state.uploadPhotoState.isFailure,
              "failure",
              equals(true),
            ).
            having((state) => state.uploadPhotoState.error?.message, "error message", equals((expectedUploadPhotoFailureResult).responseException.message))
      ],
      verify: (_) => [
        verify(
          mockUploadPhotoUseCase.invoke(photoFile: expectedFilePath),
        ).called(1),
      ],
    );


  });
}
