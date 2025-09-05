import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/profile/get_user_profile_data_use_case.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_cubit_test.mocks.dart';

@GenerateMocks([GetUserProfileDataUseCase, GlobalCubit])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetUserProfileDataUseCase mockGetUserProfileDataUseCase;
  late Result<UserDataEntity?> expectedSuccessResult;
  late Failure<UserDataEntity?> expectedFailureResult;
  late UserDataEntity userDataEntity;
  late MockGlobalCubit mockGlobalCubit;
  late ProfileCubit cubit;

  setUpAll(() {
    mockGetUserProfileDataUseCase = MockGetUserProfileDataUseCase();
    mockGlobalCubit = MockGlobalCubit();
    when(mockGlobalCubit.isArLanguage).thenAnswer((_) => false);

    userDataEntity = UserDataEntity(
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
      passwordResetCode: "password code",
    );
  });

  setUp(() {
    FloweryMethodHelper.userData = null;
    cubit = ProfileCubit(mockGetUserProfileDataUseCase);
  });

  group("Profile Cubit test", () {
    blocTest<ProfileCubit, ProfileState>(
      'emits [Loading, Success] when getUserProfileData succeeds',
      build: () {
        expectedSuccessResult = Success<UserDataEntity?>(userDataEntity);
        provideDummy<Result<UserDataEntity?>>(expectedSuccessResult);
        when(
          mockGetUserProfileDataUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult); // success
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: ProfileInitializationIntent(globalCubit: mockGlobalCubit),
      ),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.selectedLanguage,
          "selectedLanguage",
          Languages.english,
        ),
        isA<ProfileState>().having(
          (state) => state.profileStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<ProfileState>()
            .having(
              (state) => state.profileStatus.isSuccess,
              "Is Success State",
              equals(true),
            )
            .having(
              (state) => FloweryMethodHelper.userData?.email,
              "check if the userData saved correctly and equals to the expected",
              equals(
                (expectedSuccessResult as Success<UserDataEntity?>).data?.email,
              ),
            )
            .having(
              (_) => FloweryMethodHelper.userData?.id,
              "check if the userData saved correctly and equals to the expected",
              equals(
                (expectedSuccessResult as Success<UserDataEntity?>).data?.id,
              ),
            )
            .having(
              (_) => FloweryMethodHelper.userData?.passwordResetCode,
              "check if the userData saved correctly and equals to the expected",
              equals(
                (expectedSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.passwordResetCode,
              ),
            )
            .having(
              (_) => FloweryMethodHelper.userData?.addresses?.elementAt(0),
              "check if the userData saved correctly and equals to the expected",
              equals(
                (expectedSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.addresses
                    ?.elementAt(0),
              ),
            ),
      ],
      verify: (_) {
        verify(mockGetUserProfileDataUseCase.invoke()).called(1);
      },
    );

    blocTest(
      "emits [Loading, Failure] when getUserProfileData is Called",
      build: () {
        expectedFailureResult = Failure(
          responseException: const ResponseException(
            message: "failed to fetch user data",
          ),
        );
        provideDummy<Result<UserDataEntity?>>(expectedFailureResult);
        when(
          mockGetUserProfileDataUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: ProfileInitializationIntent(globalCubit: mockGlobalCubit),
      ),
      expect: () => [
        isA<ProfileState>().having(
          (state) => state.selectedLanguage,
          "selectedLanguage",
          Languages.english,
        ),
        isA<ProfileState>().having(
          (state) => state.profileStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<ProfileState>()
            .having(
              (state) => state.profileStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.profileStatus.error?.message,
              'responseException.message',
              expectedFailureResult.responseException.message,
            ),
      ],
      verify: (_) {
        verify(mockGetUserProfileDataUseCase.invoke()).called(1);
      },
    );
  });
}
