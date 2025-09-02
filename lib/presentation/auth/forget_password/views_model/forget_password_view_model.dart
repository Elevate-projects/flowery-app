 import 'package:flowery_app/api/client/api_result.dart';
 import 'package:flowery_app/domain/entities/forget_password/request/forget_password_request_entity.dart';
import 'package:flowery_app/domain/entities/forget_password/response/forget_password_response_entity.dart';
import 'package:flowery_app/domain/use_cases/forget_password/forget_password_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/validations.dart';
import 'forget_password_intent.dart';
import 'forget_password_states.dart';
 @injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState>{
 final ForgetPasswordUseCase _forgetPasswordUseCase;
  ForgetPasswordViewModel(this._forgetPasswordUseCase):super(ForgetPasswordInitial());


 void doIntent(ForgetPasswordIntent intent) {
   switch (intent) {
     case OnConfirmEmailForgetPasswordClickIntent():
       _forgetPassword(intent.request);
   }
 }

 final formKey = GlobalKey<FormState>();
 final emailController = TextEditingController();

 @override
 Future<void> close() {
   emailController.dispose();
   return super.close();
 }


 void _forgetPassword(ForgetPasswordRequestEntity request) async {
   final validationError = Validations.emailValidation(email: request.email);
   if (validationError != null) {
     emit(ForgetPasswordFailure(error: validationError));
     return;
   }
   emit(ForgetPasswordLoading());
   var res = await _forgetPasswordUseCase.call(request );
   switch (res) {
     case Success<ForgetPasswordEntity>(:final data):
       emit(ForgetPasswordSuccess( message:  data.message ?? 'Password reset link sent'));
     case Failure<ForgetPasswordEntity>(:final responseException):
       emit(ForgetPasswordFailure(error:  responseException.message ?? 'Something went wrong'));
   }
 }
}
