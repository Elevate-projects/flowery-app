import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';

class ResetPasswordState extends Equatable{
  final StateStatus<Result<void>> resetPasswordStatus;

  const ResetPasswordState({this.resetPasswordStatus = const StateStatus.initial()});

  @override
  List<Object?> get props => [resetPasswordStatus];

  ResetPasswordState copyWith({
    StateStatus<Result<void>>? resetPasswordStatus,
  }) {
    return ResetPasswordState(
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
    );
  }
}