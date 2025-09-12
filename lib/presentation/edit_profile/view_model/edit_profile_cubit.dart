import 'dart:io';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/requests/edit_profile_request/edit_profile_request_entity.dart';
import 'package:flowery_app/domain/entities/upload_photo_response_entity/upload_photo_response_entity.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/edit_profile/edit_profile_use_case.dart';
import 'package:flowery_app/domain/use_cases/edit_profile/upload_photo_use_case.dart';
import 'package:flowery_app/domain/use_cases/profile/get_user_profile_data_use_case.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_intents.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;
  final UploadPhotoUseCase _uploadPhotoUseCase;
  final ImagePicker _imagePicker = ImagePicker();
  //final GetUserProfileDataUseCase getUserData;

  EditProfileCubit(this._editProfileUseCase, this._uploadPhotoUseCase) : super(const EditProfileState());
  late GlobalKey<FormState> editFormKey;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  Gender selectedGender = Gender.male; 

  Future<void> doIntent({required EditProfileIntents intent}) async {
    switch (intent) {
      case InitializedEditProfileIntent():
        _init();
        break;
      case EditProfileWithDataIntent():
        _editProfile();

      case UploadPhotoIntent():
        _pickAndUploadPhoto();
        break;
    }
  }

  void _init() async{
    editFormKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    final currentUserData = FloweryMethodHelper.userData;
    firstNameController.text = currentUserData?.firstName ?? '';
    lastNameController.text = currentUserData?.lastName ?? '';
    emailController.text = currentUserData?.email ?? '';
    phoneNumberController.text = currentUserData?.phone ?? '';
  }

  Future<void> _editProfile() async {
    emit(state.copyWith(editProfileState: const StateStatus.loading()));
    final result = await _editProfileUseCase.invoke(
      request: EditProfileRequestEntity(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneNumberController.text,
      ),
    );
    switch (result) {
      case Success<UserDataEntity>():
        FloweryMethodHelper.userData = result.data;
        emit(state.copyWith(editProfileState: const StateStatus.success(null)));
      case Failure<UserDataEntity>():
        emit(
          state.copyWith(
            editProfileState: StateStatus.failure(result.responseException),
          ),
        );
    }
  }
  
    Future<void> _pickAndUploadPhoto() async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 8,
      );
      
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        await _uploadProfilePhoto(file);
      }
    } catch (e) {
      emit(state.copyWith(
        uploadPhotoState: StateStatus.failure(
          ResponseException(message: 'Failed to pick image: $e'),
        ),
      ));
    }
  }

  Future<void> _uploadProfilePhoto(File photoFile) async {
    emit(state.copyWith(uploadPhotoState: const StateStatus.loading()));

    final result = await _uploadPhotoUseCase.invoke(photoFile: photoFile);

    switch (result) {
      case Success<UploadPhotoResponseEntity>():
        emit(state.copyWith(
          uploadPhotoState: const StateStatus.success(null),
        ));
      case Failure<UploadPhotoResponseEntity>():
        emit(state.copyWith(
          uploadPhotoState: StateStatus.failure(result.responseException),
        ));
    }
  }
}
