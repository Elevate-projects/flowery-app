import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';

enum Status { initial, loading, success, error }

class VerificationScreenState extends Equatable {
  final Status resendCodeStatus;
  final Status verifyCodeStatus;
  final ResponseException? resendCodeError;
  final ResponseException? verifyCodeError;
  final int secondsRemaining;
  final bool isError;

  const VerificationScreenState({
    this.resendCodeStatus = Status.initial,
    this.verifyCodeStatus = Status.initial,
    this.resendCodeError,
    this.verifyCodeError,
    this.secondsRemaining = 0,
    this.isError = false,
  });

  VerificationScreenState copyWith({
    Status? resendCodeStatus,
    Status? verifyCodeStatus,
    ResponseException? resendCodeError,
    ResponseException? verifyCodeError,
    int? secondsRemaining,
    bool? isError,
  }) {
    return VerificationScreenState(
      resendCodeStatus: resendCodeStatus ?? this.resendCodeStatus,
      verifyCodeStatus: verifyCodeStatus ?? this.verifyCodeStatus,
      resendCodeError: resendCodeError ?? this.resendCodeError,
      verifyCodeError: verifyCodeError ?? this.verifyCodeError,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
    resendCodeStatus,
    verifyCodeStatus,
    resendCodeError,
    verifyCodeError,
    secondsRemaining,
    isError,
  ];
}
