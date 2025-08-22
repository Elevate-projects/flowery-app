import 'package:bloc/bloc.dart';
import 'package:flowery_app/presentation/auth/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_app/presentation/auth/reset_password/view_model/reset_password_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../api/client/api_result.dart';
import '../../../../domain/entities/reset_password/request/reset_password_request.dart';
import '../../../../domain/entities/reset_password/response/reset_password_response.dart';
import '../../../../domain/use_cases/reset_password/reset_password_usecase.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  GetResetPasswordUsecase getResetPasswordUsecase;

  @factoryMethod
  ResetPasswordCubit(this.getResetPasswordUsecase)
    : super(const ResetPasswordState());

  void doIntent(ResetPasswordIntent intent) {
    switch (intent) {
      case OnResetPasswordIntent():
        return _resetPassword(intent.request);
    }
  }

  void _resetPassword(ResetPasswordRequestEntity request) async {
    emit(state.copyWith(status: Status.loading));
    var res = await getResetPasswordUsecase.execute(request);
    switch (res) {
      case Success<ResetPasswordResponseEntity>():
        emit(state.copyWith(status: Status.success));
      case Failure<ResetPasswordResponseEntity>():
        emit(
          state.copyWith(
            status: Status.error,
            resetCodeError: res.responseException,
          ),
        );
    }
  }
}
