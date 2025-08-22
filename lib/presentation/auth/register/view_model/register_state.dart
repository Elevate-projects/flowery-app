import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';

sealed class RegisterState {}

class RegisterInitial extends RegisterState {
  final Gender selectedGender;
  RegisterInitial({this.selectedGender = Gender.male});
}
class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterFailureState extends RegisterState {
  final ResponseException  error;

  RegisterFailureState({required this.error});
}
class EnableAutoValidateModeState extends RegisterState {}

class ChangePasswordObscureState extends RegisterState {
  bool isObscure;
  ChangePasswordObscureState({this.isObscure= true});
  ChangePasswordObscureState copyWith({ required bool isObscurePass}){
    isObscurePass = !isObscurePass;
    return ChangePasswordObscureState(isObscure: isObscurePass); 
  }
}

class ChangeConfirmPasswordObscureState extends RegisterState {
  bool isObscure;
  ChangeConfirmPasswordObscureState({this.isObscure= true});

  ChangeConfirmPasswordObscureState  copyWith({required bool isObscurePass}) {
    isObscurePass = !isObscurePass;
    return ChangeConfirmPasswordObscureState(isObscure: isObscurePass);
  }
}

class GenderChangedState extends RegisterState {
  final Gender selectedGender;
  GenderChangedState({required this.selectedGender});
}

class AlreadyHaveAccountState extends RegisterState {}
