import 'package:equatable/equatable.dart';

class ForgetPasswordEntity extends Equatable {
  final String? message;
  final String? info;

  const ForgetPasswordEntity({
    this.message,
    this.info,
  });

  @override
  List<Object?> get props => [message, info];
}
