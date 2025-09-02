import 'package:equatable/equatable.dart';

class ForgetPasswordRequestEntity extends Equatable {
  String email;

  ForgetPasswordRequestEntity({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
