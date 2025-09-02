import 'package:equatable/equatable.dart';

class ForgetPasswordRequestEntity extends Equatable {
  final String email;

  const ForgetPasswordRequestEntity({
    required this.email,
  });

  @override
  List<Object?> get props => [email];
}
