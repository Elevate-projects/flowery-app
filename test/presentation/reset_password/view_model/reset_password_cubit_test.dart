import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';
import 'package:flowery_app/domain/use_cases/reset_password/reset_password_use_case.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_cubit.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../fake_form_state.dart';
import 'reset_password_cubit_test.mocks.dart';
@GenerateMocks([ResetPasswordUseCase])
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late ResetPasswordCubit resetPasswordCubit;
  late Result<ResetPasswordResponseEntity> expectedSuccessResult;
  late Failure<ResetPasswordResponseEntity> expectedFailureResult;
  late ResetPasswordResponseEntity resetPasswordResponseEntity;

  setUpAll((){
    mockResetPasswordUseCase =MockResetPasswordUseCase();
     resetPasswordResponseEntity =ResetPasswordResponseEntity(
        message: "success",
        bearerToken: "newToken",
     );
     expectedSuccessResult =Success(resetPasswordResponseEntity);
     expectedFailureResult = Failure(responseException:const ResponseException(message: "Failed to reset password"));
     provideDummy<Result<ResetPasswordResponseEntity>>(expectedSuccessResult);
     provideDummy<Result<ResetPasswordResponseEntity>>(expectedFailureResult);
  });
  setUp((){
    resetPasswordCubit =ResetPasswordCubit(mockResetPasswordUseCase);
    resetPasswordCubit.doIntent(intent:  InitializedResertPassword());
    resetPasswordCubit.resetPasswordFormKey= FakeGlobalKey(FakeFormState());
  });
  group('ResetPasswordCubit',(){
    blocTest<ResetPasswordCubit, ResetPasswordState>('emits [loading, success] when resetPassword is successful', build: (){
       when(mockResetPasswordUseCase.call(entity: anyNamed('entity'))).thenAnswer((_) async => expectedSuccessResult);
       return resetPasswordCubit;
    },
    act:(cubit)=>[cubit.doIntent(intent: ResetPasswordRequested())],
    expect: ()=>[
      isA<ResetPasswordState>()
      .having((state) => state.resetPasswordStatus.isLoading, 'loading', equals(true)),
      isA<ResetPasswordState>()
      .having((state) => state.resetPasswordStatus.isSuccess, 'success', equals(true))
      .having((state)=>state.resetPasswordStatus.data, "check the data returned", equals((expectedSuccessResult as Success<ResetPasswordResponseEntity>))),
    ],
    verify: (bloc) {
      verify(mockResetPasswordUseCase.call(entity: anyNamed('entity'))).called(1);
    },);
    blocTest<ResetPasswordCubit, ResetPasswordState>(
      'emits [loading, failure] when resetPassword fails',
      build: () {
        when(
          mockResetPasswordUseCase.call(entity: anyNamed("entity")),
        ).thenAnswer((_) async => expectedFailureResult);
        return resetPasswordCubit;
      },
      act: (cubit) => [cubit.doIntent(intent: ResetPasswordRequested())],
      expect: () => [
        isA<ResetPasswordState>().having(
          (state) => state.resetPasswordStatus.isLoading,
          "loading",
          equals(true),
        ),
        isA<ResetPasswordState>()
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
          mockResetPasswordUseCase.call(entity: anyNamed("entity")),
        ).called(1),
      ],
    );
  });

}