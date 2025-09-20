import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

class LoginState extends Equatable {
  final StateStatus<Result<UserDataEntity>?> loginStatus;
  const LoginState({this.loginStatus = const StateStatus.initial()});

  @override
  List<Object?> get props => [loginStatus];

  LoginState copyWith({StateStatus<Result<UserDataEntity>?>? loginStatus}) {
    return LoginState(loginStatus: loginStatus ?? this.loginStatus);
  }
}

final class EnableAutoValidateModeState extends LoginState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
final class ChangeObscureState extends LoginState {
  ChangeObscureState({this.isObscure = true});
  bool isObscure;

  ChangeObscureState copyWith2({required bool isObscurePassword}) {
    isObscurePassword = !isObscurePassword;
    return ChangeObscureState(isObscure: isObscurePassword);
  }

  @override
  List<Object?> get props => [isObscure];
}

// ignore: must_be_immutable
final class ToggleRememberMeState extends LoginState {
  ToggleRememberMeState({this.rememberMe = false});
  bool rememberMe;

  ToggleRememberMeState copyWith2({required bool isRememberMe}) {
    isRememberMe = !isRememberMe;
    return ToggleRememberMeState(rememberMe: isRememberMe);
  }

  @override
  List<Object?> get props => [rememberMe];
}
