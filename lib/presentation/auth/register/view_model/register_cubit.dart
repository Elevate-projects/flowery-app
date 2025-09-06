import 'dart:developer';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/request/register_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/register/register_use_case.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_intent.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;
  RegisterCubit(this._registerUseCase) : super(const RegisterState());

  late GlobalKey<FormState> registerFormKey;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController phoneNumberController;
  late AutovalidateMode autoValidateMode;
  late Gender _selectedGender; 
  ChangeConfirmPasswordObscureState _changeConfirmPasswordObscureState =
      const ChangeConfirmPasswordObscureState();
  ChangePasswordObscureState _changePasswordObscureState =
      const ChangePasswordObscureState();

  Future<void> doIntent({required RegisterIntent intent}) async {
    switch (intent) {
      case InitializedRegisterIntent():
        _init();
        break;
      case RegisterWithDataIntent():
        _register();
        break;
      case TogglePasswordVisibilityIntent():
        _togglePasswordVisiblity();
        break;
      case ToggleConfirmPasswordVisibilityIntent():
        _toggleConfirmPasswordVisiblity();
        break;
      case ChangeGenderIntent():
       _changeGender(gender: intent.gender);
        break;
      case AlreadyHaveAccountIntent():
       _alreadyHaveAccount();
    }
  }

  void _init() async {
    registerFormKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneNumberController = TextEditingController();
    _selectedGender = Gender.male;
    autoValidateMode = AutovalidateMode.disabled;
  }

  void _enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void _togglePasswordVisiblity() {
    _changePasswordObscureState = _changePasswordObscureState.copyWith2(
      isObscurePass: _changePasswordObscureState.isObscure,
    );
    log('statepass${_changeConfirmPasswordObscureState.isObscure}');
    emit(_changePasswordObscureState);
  }

  void _toggleConfirmPasswordVisiblity() {
    _changeConfirmPasswordObscureState = _changeConfirmPasswordObscureState
        .copyWith2(isObscurePass: _changeConfirmPasswordObscureState.isObscure);
    emit(_changeConfirmPasswordObscureState);
  }

  Future<void> _register() async {
    if (registerFormKey.currentState!.validate()) {
      emit(state.copyWith(registerState: const StateStatus.loading()));
      final userData = await _registerUseCase.invoke(
        request: RegisterRequestEntity(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          rePassword: confirmPasswordController.text,
          phone: phoneNumberController.text,
          gender: _selectedGender.value,
        ),
      );
      switch (userData) {
        case Success<UserDataEntity?>():
          FloweryMethodHelper.userData = userData.data;
          emit(state.copyWith(registerState: const StateStatus.success(null)));
          break;

        case Failure<UserDataEntity?>():
          emit(state.copyWith(registerState: StateStatus.failure(userData.responseException)));
          break;
      }
    } else {
      _enableAutoValidateMode();
    }
  }

  void _changeGender({required Gender gender}) {
    _selectedGender = gender;
    emit(GenderChangedState(selectedGender: gender));
  }

  void _alreadyHaveAccount() {
    emit(AlreadyHaveAccountState());
  }
}
