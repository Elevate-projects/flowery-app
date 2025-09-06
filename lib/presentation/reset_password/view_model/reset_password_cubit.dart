import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/reset_password/reset_password_request_entity.dart';
import 'package:flowery_app/domain/use_cases/reset_password/reset_password_use_case.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_intent.dart';
import 'package:flowery_app/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase _resetPasswordUseCase;
  ResetPasswordCubit(this._resetPasswordUseCase) : super(const ResetPasswordState());

   late GlobalKey<FormState> resetPasswordFormKey;
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  Future<void> doIntent({required ResetPasswordIntent intent}) async{
    switch (intent) {
       case InitializedResertPassword():
       _init();
        break;

      case ResetPasswordRequested():
        await _resetPassword();
        break;
    }
  }

  void _init() {
    resetPasswordFormKey = GlobalKey<FormState>();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  Future<void> _resetPassword() async {
      emit(state.copyWith(resetPasswordStatus: const StateStatus.loading()));
      final result = await _resetPasswordUseCase(
        entity: ResetPasswordRequestEntity(
          password: currentPasswordController.text,
          newPassword: newPasswordController.text,
        ),
      );
      switch (result) {
      case Success():
        emit(state.copyWith(resetPasswordStatus: StateStatus.success(result)));
      case Failure():
        emit(
          state.copyWith(
            resetPasswordStatus: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
}
