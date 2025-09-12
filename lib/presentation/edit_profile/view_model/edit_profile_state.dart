import 'package:equatable/equatable.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter/material.dart';

class EditProfileState extends Equatable{
  final StateStatus<Result<UserDataEntity>?> editProfileState;
  final StateStatus<Result<UploadPhotoResponseEntity>?> uploadPhotoState;
  final Gender selectedGender;

  const EditProfileState({
    this.editProfileState = const StateStatus.initial(),
    this.uploadPhotoState = const StateStatus.initial(),
    this.selectedGender = Gender.male,
  });

  @override
  List<Object?> get props => [editProfileState, uploadPhotoState, selectedGender];

  EditProfileState copyWith({
    StateStatus<Result<UserDataEntity>?>? editProfileState,
    StateStatus<Result<UploadPhotoResponseEntity>?>? uploadPhotoState,
    Gender? selectedGender,
    String? selectedImagePath,
    ImageProvider? currentImageProvider,
    bool? hasChanges,
  }) {
    return EditProfileState(
      editProfileState: editProfileState ?? this.editProfileState,
      uploadPhotoState: uploadPhotoState ?? this.uploadPhotoState,
      selectedGender: selectedGender ?? this.selectedGender,    );
  }
}