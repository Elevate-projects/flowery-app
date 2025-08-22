import 'package:equatable/equatable.dart';

sealed class ForgetPasswordState extends Equatable {
    ForgetPasswordState();

  @override
  List<Object?> get props => [];
}
class ForgetPasswordInitial extends ForgetPasswordState{

}
class ForgetPasswordLoading extends ForgetPasswordState{

}
class ForgetPasswordSuccess extends ForgetPasswordState{
  final String message;
  ForgetPasswordSuccess({required this.message});
  List<Object?> get props => [message];

}
class ForgetPasswordFailure extends ForgetPasswordState{
  final String error;

    ForgetPasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];

}
