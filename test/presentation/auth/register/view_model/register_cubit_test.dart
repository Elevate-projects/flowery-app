import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/register/register_use_case.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_cubit.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_intent.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fake_form_state.dart';
import 'register_cubit_test.mocks.dart';

@GenerateMocks([RegisterUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockRegisterUseCase mockRegisterUseCase;
  late RegisterCubit registerCubit;
  late Result<UserDataEntity?> expectedSuccessResult;
  late Failure<UserDataEntity?> expectedFailureResult;
  late UserDataEntity userDataEntity;
  setUpAll(() {
    mockRegisterUseCase = MockRegisterUseCase();
    expectedFailureResult = Failure(
      responseException: const ResponseException(message: "failed to register"),
    );
    userDataEntity = UserDataEntity(
      id: "1",
      email: "sadany@gmail.com",
      phone: "01155027741",
      firstName: "omar",
      lastName: "elsadany",
      gender: "male",
      photo: "profilePic",
      addresses: ["address1", "address2"],
      wishlist: ["item1", "item2"],
      role: "user",
    );
    expectedSuccessResult = Success<UserDataEntity?>(userDataEntity);
    provideDummy<Result<UserDataEntity?>>(expectedSuccessResult);
    provideDummy<Result<UserDataEntity?>>(expectedFailureResult);
  });

  setUp(() {
    registerCubit = RegisterCubit(mockRegisterUseCase);
    registerCubit.doIntent(intent: InitializedRegisterIntent());
    registerCubit.registerFormKey = FakeGlobalKey(FakeFormState());
  });
  group("register cubit test", () {
    blocTest<RegisterCubit, RegisterState>(
      "emits [loading, success] when register is successful",
      build: () {
        when(
          mockRegisterUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedSuccessResult);
        return registerCubit;
      },
      act: (cubit) {
        cubit.doIntent(intent: RegisterWithDataIntent());
      },
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.registerState.isLoading,
          "loading",
          equals(true),
        ),
        isA<RegisterState>()
            .having(
              (state) => state.registerState.isSuccess,
              "success",
              equals(true),
            )
            .having(
              (state) => FloweryMethodHelper.userData?.firstName,
              "check if userdata saved successfully and eqauls to the excpeted data",
              equals(
                (expectedSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.firstName,
              ),
            )
            .having(
              (state) => FloweryMethodHelper.userData?.lastName,
              "check if userdata saved successfully and eqauls to the excpeted data",
              equals(
                (expectedSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.lastName,
              ),
            )
            .having(
              (state) => FloweryMethodHelper.userData?.gender,
              "check if userdata saved successfully and eqauls to the excpeted data",
              equals(
                (expectedSuccessResult as Success<UserDataEntity?>)
                    .data
                    ?.gender,
              ),
            ),
      ],
      verify: (_) {
        verify(
          mockRegisterUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );
    blocTest<RegisterCubit, RegisterState>(
      "emits [loading, failure] when register fails",
      build: () {
        when(
          mockRegisterUseCase.invoke(request: anyNamed("request")),
        ).thenAnswer((_) async => expectedFailureResult);
        return registerCubit;
      },
      act: (cubit) {
        cubit.doIntent(intent: RegisterWithDataIntent());
      },
      expect: () => [
        isA<RegisterState>().having(
          (state) => state.registerState.isLoading,
          "loading",
          equals(true),
        ),
        isA<RegisterState>()
            .having(
              (state) => state.registerState.isFailure,
              "failure",
              equals(true),
            )
            .having(
              (state) => state.registerState.error?.message,
              " response exception message",
              equals((expectedFailureResult).responseException.message),
            ),
      ],
      verify: (_) {
        verify(
          mockRegisterUseCase.invoke(request: anyNamed("request")),
        ).called(1);
      },
    );

    blocTest<RegisterCubit, RegisterState>(
      'emits ChangePasswordObscureState when TogglePasswordVisibilityIntent and its value changes',
      build: () {
        return registerCubit;
      },
      act: (cubit) => cubit.doIntent(intent: TogglePasswordVisibilityIntent()),
      expect: () => [
        isA<ChangePasswordObscureState>().having(
          (state) => state.isObscure,
          "check that its value changed",
          equals(false),
        ),
      ],
    );
  });
}
