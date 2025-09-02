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

final class ChangeObscureState extends LoginState {
  const ChangeObscureState({this.isObscure = true});
  final bool isObscure;

  ChangeObscureState copyWith2({bool? isObscure}) {
    return ChangeObscureState(isObscure: isObscure ?? this.isObscure);
  }

  ChangeObscureState toggle() => ChangeObscureState(isObscure: !isObscure);

  @override
  List<Object?> get props => [isObscure];
}
final class ToggleRememberMeState extends LoginState {
  const ToggleRememberMeState({this.rememberMe = false});
  final bool rememberMe;

  ToggleRememberMeState copyWith2({bool? rememberMe}) {
    return ToggleRememberMeState(rememberMe: rememberMe ?? this.rememberMe);
  }

  ToggleRememberMeState toggle() => ToggleRememberMeState(rememberMe: !rememberMe);

  @override
  List<Object?> get props => [rememberMe];
}
