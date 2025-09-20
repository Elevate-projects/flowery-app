
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/forget_password/forget_password_entity.dart';
import 'package:flowery_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_states.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'forget_password_view_model_test.mocks.dart';


@GenerateMocks([ForgetPasswordUseCase])
void main() {
  late MockForgetPasswordUseCase forgetPasswordUseCase;

  final request = const ForgetPasswordRequestEntity(
    email: 'Peter1@gmail.com',
  );
  final expectedResponse = const ForgetPasswordEntity(
    message: 'Forget password test',
  );
  final expectedResult = Success(expectedResponse);
  setUp(() {
    forgetPasswordUseCase = MockForgetPasswordUseCase();
    provideDummy<Result<ForgetPasswordEntity>>(expectedResult);

    when(
      forgetPasswordUseCase.call(request),
    ).thenAnswer((_) async => expectedResult);
  });
  blocTest<ForgetPasswordViewModel, ForgetPasswordState>(
    'should emit [loading, success] when ForgetPassword is successful',
    build: () => ForgetPasswordViewModel(forgetPasswordUseCase),
    act: (cubit) =>
        cubit.doIntent(OnConfirmEmailForgetPasswordClickIntent(request: request)),
    expect: () => [
      ForgetPasswordLoading(),
      const ForgetPasswordSuccess(message: 'Forget password test'),     ],
  );
}


