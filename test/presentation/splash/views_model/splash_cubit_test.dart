import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/splash/get_user_data_use_case.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_cubit.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_intent.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'splash_cubit_test.mocks.dart';

@GenerateMocks([GetUserDataUseCase, SecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockGetUserDataUseCase mockGetUserDataUseCase;
  late MockSecureStorage mockSecureStorage;
  late SplashCubit cubit;
  late Result<UserDataEntity?> expectedSuccessResult;
  late Failure<UserDataEntity?> expectedFailureResult;
  late UserDataEntity userDataEntity;

  setUpAll(() {
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    mockSecureStorage = MockSecureStorage();
    expectedFailureResult = Failure(
      responseException: const ResponseException(message: "failed to login"),
    );
    userDataEntity = UserDataEntity(
      id: "1",
      email: "ahmed@gmail.com",
      phone: "01116811741",
      firstName: "ahmed",
      lastName: "tarek",
      gender: "male",
      photo: "profilePic",
      addresses: ["address1", "address2"],
      wishlist: ["item1", "item2"],
      role: "developer",
    );
    expectedSuccessResult = Success<UserDataEntity?>(userDataEntity);
    provideDummy<Result<UserDataEntity?>>(expectedSuccessResult);
    provideDummy<Result<UserDataEntity?>>(expectedFailureResult);
  });
  setUp(() {
    cubit = SplashCubit(mockGetUserDataUseCase, mockSecureStorage);
  });

  group("Splash cubit test", () {
    blocTest<SplashCubit, SplashState>(
      'emits [Loading, Success] when GetUserDataIntent succeeds',
      build: () {
        when(
          mockGetUserDataUseCase.invoke(),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: GetUserDataIntent()),
      expect: () => [
        isA<FetchUserDataLoadingState>(),
        isA<FetchUserDataSuccessState>()
            .having(
              (_) => FloweryMethodHelper.userData?.email,
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
        verify(mockGetUserDataUseCase.invoke()).called(1);
      },
    );

    blocTest(
      "emits [Loading, Failure] when GetUserDataIntent is Called",
      build: () {
        when(
          mockGetUserDataUseCase.invoke(),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: GetUserDataIntent()),
      expect: () => [
        isA<FetchUserDataLoadingState>(),
        isA<FetchUserDataFailureState>().having(
          (state) => state.errorData.message,
          'responseException.message',
          expectedFailureResult.responseException.message,
        ),
      ],
      verify: (_) {
        verify(mockGetUserDataUseCase.invoke()).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'emits [LoginNavigationState] when NavigateToLoginViewIntent is Called',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: NavigateToLoginViewIntent()),
      expect: () => [
        isA<LoginNavigationState>()
            .having(
              (_) => FloweryMethodHelper.userData,
              'when NavigateToLoginViewIntent is called userData should be reset to null',
              null,
            )
            .having(
              (_) => FloweryMethodHelper.currentUserToken,
              'when NavigateToLoginViewIntent is called currentUserToken should be reset to null',
              null,
            ),
      ],
    );
  });
}
