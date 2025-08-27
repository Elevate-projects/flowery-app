import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';

class RegisterState extends Equatable{
  final StateStatus<Result<UserDataEntity>?> registerState;
  const RegisterState({this.registerState = const StateStatus.initial()});

  @override
  List<Object?> get props => [registerState];

  RegisterState copyWith({StateStatus<Result<UserDataEntity>?>? registerState}) {
    return RegisterState(
      registerState: registerState ?? this.registerState
    );
  }
}

final class EnableAutoValidateModeState extends RegisterState {
    @override
      List<Object?> get props => [];
 }

final class ChangePasswordObscureState extends RegisterState {
  final bool isObscure;
  const ChangePasswordObscureState({this.isObscure= true});
  ChangePasswordObscureState copyWith2({ required bool isObscurePass}){
    isObscurePass = !isObscurePass;
    return ChangePasswordObscureState(isObscure: isObscurePass); 
  }
    @override
  List<Object?> get props => [isObscure];
}

final class ChangeConfirmPasswordObscureState extends RegisterState {
  final bool isObscure;
  const ChangeConfirmPasswordObscureState({this.isObscure= true});

  ChangeConfirmPasswordObscureState  copyWith2({required bool isObscurePass}) {
    isObscurePass = !isObscurePass;
    return ChangeConfirmPasswordObscureState(isObscure: isObscurePass);
  }
    @override
  List<Object?> get props => [isObscure];
}

final class GenderChangedState extends RegisterState {
  final Gender selectedGender;
  const GenderChangedState({required this.selectedGender});
    @override
  List<Object?> get props => [selectedGender];
}

final class AlreadyHaveAccountState extends RegisterState {
    @override
  List<Object?> get props => [];
}
