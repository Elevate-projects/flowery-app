import 'dart:async';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/resend_code/response/resend_code_response.dart';
import 'package:flowery_app/domain/entities/verification/response/verify_response.dart';
import 'package:flowery_app/domain/use_cases/resend_code/resend_code_usecase.dart';
import 'package:flowery_app/domain/use_cases/verification/verification_usecase.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_intent.dart';
import 'package:flowery_app/presentation/auth/verification/views_model/verification_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/resend_code/request/resend_code_request.dart';
import '../../../../domain/entities/verification/request/verify_requset.dart';

@injectable
class VerificationScreenCubit extends Cubit<VerificationScreenState> {
  final GetResendCodeUsecase _getResendCodeUsecase;
  final GetVerificationUsecase _getVerificationUsecase;

  Timer? _timer;

  VerificationScreenCubit(
    this._getResendCodeUsecase,
    this._getVerificationUsecase,
  ) : super(const VerificationScreenState());

  void doIntent(VerificationScreenIntent intent) {
    switch (intent) {
      case OnResendClickIntent():
        return _resendCode(intent.request);
      case OnVerificationIntent():
        return _verify(intent.request);
      case OnStartTimer():
        return _startTimer();
    }
  }

  void _resendCode(ResendCodeRequestEntity request) async {
    emit(state.copyWith(resendCodeStatus: Status.loading));
    var res = await _getResendCodeUsecase.execute(request);
    switch (res) {
      case Success<ResendCodeResponseEntity>():
        _startTimer();
        emit(state.copyWith(resendCodeStatus: Status.success));
      case Failure<ResendCodeResponseEntity>():
        emit(
          state.copyWith(
            resendCodeStatus: Status.error,
            resendCodeError: res.responseException,
          ),
        );
    }
  }

  void _verify(VerifyRequsetEntity request) async {
    emit(state.copyWith(verifyCodeStatus: Status.loading));
    var res = await _getVerificationUsecase.execute(request);
    switch (res) {
      case Success<VerifyResponseEntity>():
        emit(state.copyWith(verifyCodeStatus: Status.success, isError: false));
      case Failure<VerifyResponseEntity>():
        emit(
          state.copyWith(
            verifyCodeStatus: Status.error,
            verifyCodeError: res.responseException,
            isError: true,
          ),
        );
    }
  }

  void _startTimer() {
    _timer?.cancel();
    int seconds = 30;
    emit(state.copyWith(secondsRemaining: seconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        emit(state.copyWith(secondsRemaining: seconds));
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
