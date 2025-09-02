import 'package:equatable/equatable.dart';

class ForgetPasswordEntity extends Equatable {
  final String? message;
  final String? info;

  ForgetPasswordEntity({
    this.message,
    this.info,
  });

  @override
  List<Object?> get props => [message, info];
}
