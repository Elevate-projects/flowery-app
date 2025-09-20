import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/requests/login_request/login_request_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/login/login_with_email_and_password_use_case.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_intent.dart';
import 'package:flowery_app/presentation/auth/login/views_model/login_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final SecureStorage _secureStorage;
  final SharedPreferencesHelper _sharedPreferencesHelper;
  @factoryMethod
  LoginCubit(
    this._loginWithEmailAndPasswordUseCase,
    this._secureStorage,
    this._sharedPreferencesHelper,
  ) : super(const LoginState());

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late AutovalidateMode autoValidateMode;
  late GlobalKey<FormState> loginFormKey;
  ChangeObscureState _obscurePasswordState = ChangeObscureState();
  ToggleRememberMeState _toggleRememberMeState = ToggleRememberMeState();

  Future<void> doIntent({required LoginIntent intent}) async {
    switch (intent) {
      case InitializeLoginFormIntent():
        _onInit();
        break;
      case LoginWithEmailAndPasswordIntent():
        await _login();
        break;
      case ToggleObscurePasswordIntent():
        _toggleObscure();
        break;
      case ToggleRememberMeIntent():
        await _toggleRememberMe();
        break;
      case LoginAsGuestIntent():
        _loginAsGuest();
        break;
    }
  }

  void _onInit() async {
    loginFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    autoValidateMode = AutovalidateMode.disabled;
    _getRememberMeValue();
    if (_toggleRememberMeState.rememberMe) await _getRememberedUserData();
  }

  void _enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void _toggleObscure() {
    _obscurePasswordState = _obscurePasswordState.copyWith2(
      isObscurePassword: _obscurePasswordState.isObscure,
    );
    emit(_obscurePasswordState);
  }

  void _getRememberMeValue() {
    final bool isRemembered = _sharedPreferencesHelper.getBool(
      key: ConstKeys.rememberMe,
    );
    _toggleRememberMeState = _toggleRememberMeState.copyWith2(
      isRememberMe: !isRemembered,
    );
    emit(_toggleRememberMeState);
  }

  Future<void> _toggleRememberMe() async {
    _toggleRememberMeState = _toggleRememberMeState.copyWith2(
      isRememberMe: _toggleRememberMeState.rememberMe,
    );
    await _sharedPreferencesHelper.saveBool(
      key: ConstKeys.rememberMe,
      value: _toggleRememberMeState.rememberMe,
    );
    await _forgetUserData();
    emit(_toggleRememberMeState);
  }

  Future<void> _rememberUserData() async {
    await _secureStorage.saveData(
      key: ConstKeys.email,
      value: emailController.text,
    );
    await _secureStorage.saveData(
      key: ConstKeys.password,
      value: passwordController.text,
    );
  }

  Future<void> _forgetUserData() async {
    await _secureStorage.deleteData(key: ConstKeys.email);
    await _secureStorage.deleteData(key: ConstKeys.password);
  }

  Future<void> _getRememberedUserData() async {
    emailController.text =
        await _secureStorage.getData(key: ConstKeys.email) ?? "";
    passwordController.text =
        await _secureStorage.getData(key: ConstKeys.password) ?? "";
  }

  Future<void> _login() async {
    if (loginFormKey.currentState!.validate()) {
      emit(state.copyWith(loginStatus: const StateStatus.loading()));
      final userData = await _loginWithEmailAndPasswordUseCase.invoke(
        request: LoginRequestEntity(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      switch (userData) {
        case Success<UserDataEntity?>():
          {
            FloweryMethodHelper.userData = userData.data;
            if (_toggleRememberMeState.rememberMe) await _rememberUserData();
            emit(state.copyWith(loginStatus: const StateStatus.success(null)));
            break;
          }
        case Failure<UserDataEntity?>():
          emit(
            state.copyWith(
              loginStatus: StateStatus.failure(userData.responseException),
            ),
          );
          break;
      }
    } else {
      _enableAutoValidateMode();
    }
  }

  void _loginAsGuest() {
    emit(state.copyWith(loginStatus: const StateStatus.success(null)));
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
