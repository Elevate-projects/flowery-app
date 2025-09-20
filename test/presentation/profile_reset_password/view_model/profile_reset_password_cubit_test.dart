import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';
import 'package:flowery_app/domain/use_cases/profile_reset_password/profile_reset_password_use_case.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_cubit.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_intent.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fake_form_state.dart';
import 'profile_reset_password_cubit_test.mocks.dart';
@GenerateMocks([ProfileResetPasswordUseCase])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockProfileResetPasswordUseCase mockProfileResetPasswordUseCase;
  late ProfileResetPasswordCubit profileResetPasswordCubit;
  late Result<ProfileResetPasswordResponseEntity> expectedSuccessResult;
  late Failure<ProfileResetPasswordResponseEntity> expectedFailureResult;
  late ProfileResetPasswordResponseEntity profileResetPasswordResponseEntity;

  setUpAll((){
    mockProfileResetPasswordUseCase =MockProfileResetPasswordUseCase();
     profileResetPasswordResponseEntity =ProfileResetPasswordResponseEntity(
        message: "success",
        bearerToken: "newToken",
     );
     expectedSuccessResult =Success(profileResetPasswordResponseEntity);
     expectedFailureResult = Failure(responseException:const ResponseException(message: "Failed to reset password"));
     provideDummy<Result<ProfileResetPasswordResponseEntity>>(expectedSuccessResult);
     provideDummy<Result<ProfileResetPasswordResponseEntity>>(expectedFailureResult);
  });
  setUp((){
    profileResetPasswordCubit =ProfileResetPasswordCubit(mockProfileResetPasswordUseCase);
    profileResetPasswordCubit.doIntent(intent:  InitializedProfileResetPassword());
    profileResetPasswordCubit.resetPasswordFormKey= FakeGlobalKey(FakeFormState());
  });
  group('ProfileResetPasswordCubit',(){
    blocTest<ProfileResetPasswordCubit, ProfileResetPasswordState>('emits [loading, success] when resetPassword is successful', build: (){
       when(mockProfileResetPasswordUseCase.call(entity: anyNamed('entity'))).thenAnswer((_) async => expectedSuccessResult);
       return profileResetPasswordCubit;
    },
    act:(cubit)=>[cubit.doIntent(intent: ProfileResetPasswordRequested())],
    expect: ()=>[
      isA<ProfileResetPasswordState>()
      .having((state) => state.resetPasswordStatus.isLoading, 'loading', equals(true)),
      isA<ProfileResetPasswordState>()
      .having((state) => state.resetPasswordStatus.isSuccess, 'success', equals(true))
      .having((state)=>state.resetPasswordStatus.data, "check the data returned", equals((expectedSuccessResult as Success<ProfileResetPasswordResponseEntity>))),
    ],
    verify: (bloc) {
      verify(mockProfileResetPasswordUseCase.call(entity: anyNamed('entity'))).called(1);
    },);
    blocTest<ProfileResetPasswordCubit, ProfileResetPasswordState>(
      'emits [loading, failure] when resetPassword fails',
      build: () {
        when(
          mockProfileResetPasswordUseCase.call(entity: anyNamed("entity")),
        ).thenAnswer((_) async => expectedFailureResult);
        return profileResetPasswordCubit;
      },
      act: (cubit) => [cubit.doIntent(intent: ProfileResetPasswordRequested())],
      expect: () => [
        isA<ProfileResetPasswordState>().having(
          (state) => state.resetPasswordStatus.isLoading,
          "loading",
          equals(true),
        ),
        isA<ProfileResetPasswordState>()
            .having(
              (state) => state.resetPasswordStatus.isFailure,
              "failure",
              equals(true),
            )
            .having(
              (state) => state.resetPasswordStatus.error?.message,
              "response exception message",
              equals((expectedFailureResult).responseException.message),
            ),
      ],
      verify: (_) => [
        verify(
          mockProfileResetPasswordUseCase.call(entity: anyNamed("entity")),
        ).called(1),
      ],
    );
  });

}