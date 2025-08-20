import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/requests/login_request/login_request.dart';
import 'package:flowery_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/secure_storage/secure_storage.dart';
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
  ) : super(LoginInitial());

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late AutovalidateMode autoValidateMode;
  late GlobalKey<FormState> loginFormKey;
  late bool rememberMe;
  ChangeObscureState _obscurePasswordState = ChangeObscureState();

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
    if (rememberMe) await _getRememberedUserData();
  }

  void _enableAutoValidateMode() {
    autoValidateMode = AutovalidateMode.always;
    emit(EnableAutoValidateModeState());
  }

  void _toggleObscure() {
    _obscurePasswordState = _obscurePasswordState.copyWith(
      isObscurePassword: _obscurePasswordState.isObscure,
    );
    emit(_obscurePasswordState);
  }

  void _getRememberMeValue() {
    rememberMe = _sharedPreferencesHelper.getBool(key: ConstKeys.rememberMe);
  }

  Future<void> _toggleRememberMe() async {
    rememberMe = !rememberMe;
    await _sharedPreferencesHelper.saveBool(
      key: ConstKeys.rememberMe,
      value: rememberMe,
    );
    await _forgetUserData();
    emit(ToggleRememberMeState());
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
      emit(LoginLoadingState());
      var userData = await _loginWithEmailAndPasswordUseCase.invoke(
        request: LoginRequest(
          email: emailController.text,
          password: passwordController.text,
        ),
      );
      switch (userData) {
        case Success<UserDataEntity?>():
          {
            FloweryMethodHelper.userData = userData.data;
            if (rememberMe) await _rememberUserData();
            emit(LoginSuccessState());
            break;
          }
        case Failure<UserDataEntity?>():
          emit(LoginFailureState(errorData: userData.responseException));
          break;
      }
    } else {
      _enableAutoValidateMode();
    }
  }

  void _loginAsGuest() {
    emit(LoginAsGuestState());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
