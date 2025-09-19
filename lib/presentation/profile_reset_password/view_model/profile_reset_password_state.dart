import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/profile_reset_password_response_entity.dart/profile_reset_password_response_entity.dart';
import 'package:flutter/material.dart';

class ProfileResetPasswordState extends Equatable{
  final StateStatus<Result<ProfileResetPasswordResponseEntity>> resetPasswordStatus;
  final bool isTyping;
  final AutovalidateMode autoValidateMode;

  const ProfileResetPasswordState({this.resetPasswordStatus = const StateStatus.initial(), this.isTyping = false, this.autoValidateMode = AutovalidateMode.disabled});

  @override
  List<Object?> get props => [resetPasswordStatus, isTyping, autoValidateMode];

  ProfileResetPasswordState copyWith({
    StateStatus<Result<ProfileResetPasswordResponseEntity>>? resetPasswordStatus,
    bool? isTyping,
    AutovalidateMode? autoValidateMode,
  }) {
    return ProfileResetPasswordState(
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      isTyping: isTyping ?? this.isTyping,
      autoValidateMode: autoValidateMode ?? this.autoValidateMode,
    );
  }
}