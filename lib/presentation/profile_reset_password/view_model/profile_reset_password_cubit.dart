import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/profile_reset_password/profile_reset_password_request_entity.dart';
import 'package:flowery_app/domain/use_cases/profile_reset_password/profile_reset_password_use_case.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_intent.dart';
import 'package:flowery_app/presentation/profile_reset_password/view_model/profile_reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileResetPasswordCubit extends Cubit<ProfileResetPasswordState> {
  final ProfileResetPasswordUseCase _resetPasswordUseCase;
  ProfileResetPasswordCubit(this._resetPasswordUseCase)
    : super(const ProfileResetPasswordState());

  late GlobalKey<FormState> resetPasswordFormKey;
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  Future<void> doIntent({required ProfileResetPasswordIntent intent}) async {
    switch (intent) {
      case InitializedProfileResetPassword():
        _init();
        break;

      case ProfileResetPasswordRequested():
        await _resetPassword();
        break;
      case IsTypingIntent():
        _isTyping();
        break;
    }
  }

  void _init() {
    resetPasswordFormKey = GlobalKey<FormState>();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emit(state.copyWith(autoValidateMode: AutovalidateMode.disabled));
  }

  Future<void> _resetPassword() async {
    if(resetPasswordFormKey.currentState!.validate()){
   emit(state.copyWith(resetPasswordStatus: const StateStatus.loading()));
    final result = await _resetPasswordUseCase(
      entity: ProfileResetPasswordRequestEntity(
        password: currentPasswordController.text,
        newPassword: newPasswordController.text,
      ),
    );
    switch (result) {
      case Success():
        emit(state.copyWith(resetPasswordStatus: StateStatus.success(result)));
        break;
      case Failure():
        emit(
          state.copyWith(
            resetPasswordStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  } else {
    _enableAutoValidateMode();
  }
  }

  void _isTyping() {
    if (currentPasswordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      emit(state.copyWith(isTyping: true));
      return;
    } else {
      emit(state.copyWith(isTyping: false));
    }
  }

   void _enableAutoValidateMode() {
    emit(state.copyWith(autoValidateMode: AutovalidateMode.always));
  }
}
