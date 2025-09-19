import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flutter/material.dart';

class EditProfileState extends Equatable {
  final StateStatus<void> editProfileState;
  final StateStatus<File> uploadPhotoState;
  final Gender selectedGender;
  final bool hasChanges;
  const EditProfileState({
    this.editProfileState = const StateStatus.initial(),
    this.uploadPhotoState = const StateStatus.initial(),
    this.selectedGender = Gender.male,
    this.hasChanges = false,
  });

  @override
  List<Object?> get props => [
    editProfileState,
    uploadPhotoState,
    selectedGender,
    hasChanges,
  ];

  EditProfileState copyWith({
    StateStatus<void>? editProfileState,
    StateStatus<File>? uploadPhotoState,
    Gender? selectedGender,
    String? selectedImagePath,
    ImageProvider? currentImageProvider,
    bool? hasChanges,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
      selectedGender: selectedGender ?? this.selectedGender,
      hasChanges: hasChanges ?? this.hasChanges,
    );
  }
}
