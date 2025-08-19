import 'package:equatable/equatable.dart';

class ResendCodeResponseEntity extends Equatable {
  final String? message;
  final String? info;

  ResendCodeResponseEntity({this.message, this.info});

  @override
  List<Object?> get props => [message, info];
}
