import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';

enum Status { initial, loading, success, error }

class VerificationScreenState extends Equatable {
  final Status resendCodeStatus;
  final Status verifyCodeStatus;
  final ResponseException? resendCodeError;
  final ResponseException? verifyCodeError;

  const VerificationScreenState({
    this.resendCodeStatus = Status.initial,
    this.verifyCodeStatus = Status.initial,
    this.resendCodeError,
    this.verifyCodeError,
  });

  VerificationScreenState copyWith({
    Status? resendCodeStatus,
    Status? verifyCodeStatus,
    ResponseException? resendCodeError,
    ResponseException? verifyCodeError,
  }) {
    return VerificationScreenState(
      resendCodeStatus: resendCodeStatus ?? this.resendCodeStatus,
      verifyCodeStatus: verifyCodeStatus ?? this.verifyCodeStatus,
      resendCodeError: resendCodeError ?? this.resendCodeError,
      verifyCodeError: verifyCodeError ?? this.verifyCodeError,
    );
  }

  @override
  List<Object?> get props => [
    resendCodeStatus,
    verifyCodeStatus,
    resendCodeError,
    verifyCodeError,
  ];
}
