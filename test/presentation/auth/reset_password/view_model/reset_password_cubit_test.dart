import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/reset_password/request/reset_password_request.dart';
import 'package:flowery_app/domain/entities/reset_password/response/reset_password_response.dart';
import 'package:flowery_app/domain/use_cases/reset_password/reset_password_usecase.dart';
import 'package:flowery_app/presentation/auth/reset_password/view_model/reset_password_cubit.dart';
import 'package:flowery_app/presentation/auth/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_app/presentation/auth/reset_password/view_model/reset_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reset_password_cubit_test.mocks.dart';

@GenerateMocks([GetResetPasswordUseCase])
void main() {
  late MockGetResetPasswordUsecase getResetPasswordUseCase;

  final resetCodeRequest = ResetPasswordRequestEntity(
    email: 'moaazhassan559@gmail.com',
    newPassword: 'newPassword123',
  );

  final expectedResponse = ResetPasswordResponseEntity(
    token: 'newlyGeneratedToken',
    code: 200,
    message: 'Password reset successfully',
  );

  final expectedResult = Success(expectedResponse);
  setUp(() {
    getResetPasswordUseCase = MockGetResetPasswordUsecase();
    provideDummy<Result<ResetPasswordResponseEntity>>(expectedResult);

    when(
      getResetPasswordUseCase.execute(resetCodeRequest),
    ).thenAnswer((_) async => expectedResult);
  });
  blocTest<ResetPasswordCubit, ResetPasswordState>(
    'should emit [loading, success] when reset code is successful',
    build: () => ResetPasswordCubit(getResetPasswordUseCase),
    act: (cubit) =>
        cubit.doIntent(OnResetPasswordIntent(request: resetCodeRequest)),
    expect: () => [
      const ResetPasswordState(status: Status.loading),
      const ResetPasswordState(status: Status.success),
    ],
  );
}
