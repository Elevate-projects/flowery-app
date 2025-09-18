import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/reset_password_response_entity.dart/reset_password_response_entity.dart';
import 'package:flutter/material.dart';

class ResetPasswordState extends Equatable{
  final StateStatus<Result<ResetPasswordResponseEntity>> resetPasswordStatus;
  final bool isTyping;
  final AutovalidateMode autoValidateMode;

  const ResetPasswordState({this.resetPasswordStatus = const StateStatus.initial(), this.isTyping = false, this.autoValidateMode = AutovalidateMode.disabled});

  @override
  List<Object?> get props => [resetPasswordStatus, isTyping, autoValidateMode];

  ResetPasswordState copyWith({
    StateStatus<Result<ResetPasswordResponseEntity>>? resetPasswordStatus,
    bool? isTyping,
    AutovalidateMode? autoValidateMode,
  }) {
    return ResetPasswordState(
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      isTyping: isTyping ?? this.isTyping,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }
}