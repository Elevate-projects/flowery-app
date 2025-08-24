import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_cubit.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'login_cubit_test.mocks.dart';

@GenerateMocks([
  LoginWithEmailAndPasswordUseCase,
  SecureStorage,
  SharedPreferencesHelper,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockLoginWithEmailAndPasswordUseCase
  mockLoginWithEmailAndPasswordUseCase;
  late MockSecureStorage mockSecureStorage;
  late MockSharedPreferencesHelper mockSharedPreferencesHelper;
  late LoginCubit cubit;
  late Result<UserDataEntity?> expectedSuccessResult;
  late Failure<UserDataEntity?> expectedFailureResult;
  late UserDataEntity userDataEntity;

  setUpAll(() {
    mockLoginWithEmailAndPasswordUseCase =
        MockLoginWithEmailAndPasswordUseCase();
    mockSecureStorage = MockSecureStorage();
    mockSharedPreferencesHelper = MockSharedPreferencesHelper();
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
    when(
      mockSharedPreferencesHelper.getBool(key: ConstKeys.rememberMe),
    ).thenAnswer((_) => true);
    when(
      mockSecureStorage.getData(key: ConstKeys.email),
    ).thenAnswer((_) async => "ahmed@gmail.com");
    when(
      mockSecureStorage.getData(key: ConstKeys.password),
    ).thenAnswer((_) async => "Ahmed\$123");
  });
  setUp(() {
    cubit = LoginCubit(
      mockLoginWithEmailAndPasswordUseCase,
      mockSecureStorage,
      mockSharedPreferencesHelper,
    );
    cubit.doIntent(intent: InitializeLoginFormIntent());
    cubit.loginFormKey = FakeGlobalKey(FakeFormState());
  });

  group("Login cubit test", () {
    blocTest<LoginCubit, LoginState>(
      'emits [Loading, Success] when LoginWithEmailAndPasswordIntent succeeds',
      build: () {
        when(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).thenAnswer((_) async => expectedSuccessResult); // success
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.loginStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<LoginState>()
            .having(
              (state) => state.loginStatus.isSuccess,
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
        verify(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).called(1);
      },
    );

    blocTest(
      "emits [Loading, Failure] when LoginWithEmailAndPasswordIntent is Called",
      build: () {
        when(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) => cubit.doIntent(intent: LoginWithEmailAndPasswordIntent()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.loginStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<LoginState>()
            .having(
              (state) => state.loginStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.loginStatus.error?.message,
              'responseException.message',
              expectedFailureResult.responseException.message,
            ),
      ],
      verify: (_) {
        verify(
          mockLoginWithEmailAndPasswordUseCase.invoke(
            request: anyNamed("request"),
          ),
        ).called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits ChangeObscureState when toggling password visibility',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: ToggleObscurePasswordIntent()),
      expect: () => [
        isA<ChangeObscureState>().having(
          (state) => state.isObscure,
          'when toggle password obscure its value will be changed to false',
          false,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits ToggleRememberMeState when toggling RememberMe',
      build: () => cubit,
      act: (cubit) async =>
          await cubit.doIntent(intent: ToggleRememberMeIntent()),
      expect: () => [
        isA<ToggleRememberMeState>().having(
          (state) => state.rememberMe,
          "Is remember me value changed",
          equals(true),
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits LoginAsGuestState when Login As Guest',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(intent: LoginAsGuestIntent()),
      expect: () => [
        isA<LoginState>().having(
          (state) => state.loginStatus.isSuccess,
          "Is Success State",
          equals(true),
        ),
      ],
    );
  });
}
