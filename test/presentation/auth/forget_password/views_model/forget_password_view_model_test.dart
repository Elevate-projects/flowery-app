import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:flowery_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_states.dart';
import 'package:flowery_app/presentation/auth/forget_password/views_model/forget_password_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'forget_password_view_model_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase])
void main() {
  test('ForgetPasswordViewModel should emit [Loading, Success] when email is valid and use case succeeds', () {
    var mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    var forgetPasswordViewModel = ForgetPasswordViewModel(
      mockForgetPasswordUseCase,
    );
    var requestEntity = ForgetPasswordRequestEntity(email: 'test@gmail.com');
    var expectedResponse = ForgetPasswordResponseEntity(
      message: 'success',
      info: 'sss',
    );
    var expectedResult = Success(expectedResponse);
    provideDummy<Result<ForgetPasswordResponseEntity>>(expectedResult);
    when(
      mockForgetPasswordUseCase.call(requestEntity),
    ).thenAnswer((_) async => expectedResult);
    blocTest<ForgetPasswordViewModel,ForgetPasswordState>(
      'calling doIntent with OnConfirmEmailForgetPasswordClickIntent should call forget password use case',
      build: () =>forgetPasswordViewModel ,
      act: (ForgetPasswordViewModel forgetPasswordViewModel) {
        forgetPasswordViewModel.doIntent(OnConfirmEmailForgetPasswordClickIntent(request: requestEntity));
      },
      expect: () => [
        ForgetPasswordLoading(),
        ForgetPasswordSuccess(message:'success'),
      ],
      verify: (cubit) {
        verify(mockForgetPasswordUseCase(requestEntity)).called(1);
      },
    );

  }
  );

}
