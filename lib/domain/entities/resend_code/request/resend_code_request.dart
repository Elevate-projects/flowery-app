import 'package:equatable/equatable.dart';

class ResendCodeRequestEntity extends Equatable {
  String? email;

  ResendCodeRequestEntity({required this.email});

  @override
  List<Object?> get props => [email];
}
