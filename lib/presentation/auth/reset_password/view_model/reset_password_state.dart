import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';

enum Status { initial, loading, success, error }

class ResetPasswordState extends Equatable {
  final Status status;
  final ResponseException? resetCodeError;

  const ResetPasswordState({this.status = Status.initial, this.resetCodeError});

  ResetPasswordState copyWith({
    Status? status,
    ResponseException? resetCodeError,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      resetCodeError: resetCodeError ?? this.resetCodeError,
    );
  }

  @override
  List<Object?> get props => [status, resetCodeError];
}
