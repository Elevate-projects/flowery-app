import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_button.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_form.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_picture.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_radio_gender_row.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileDetails extends StatelessWidget {
  const EditProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state.uploadPhotoState.isSuccess) {
          Loaders.showSuccessMessage(
            message: AppText.profilePicSuccessMessage,
            context: context,
          );
        }
        if (state.uploadPhotoState.isFailure) {
          Loaders.showErrorMessage(
            message:
                state.uploadPhotoState.error?.message ??
                AppText.anUnknownErrorOccurred,
            context: context,
          );
        }
        if (state.editProfileState.isSuccess) {
          Loaders.showSuccessMessage(
            message: AppText.profileUpdateSuccessMessage,
            context: context,
          );
        } else if (state.editProfileState.isFailure) {
          Loaders.showErrorMessage(
            message:
                state.editProfileState.error?.message ??
                AppText.anUnknownErrorOccurred,
            context: context,
          );
        }
      },
      child: const Column(
        children: [
          EditProfilePicture(),
          RSizedBox(height: 24),
          EditProfileForm(),
          RSizedBox(height: 24),
          EditProfileRadioGenderRow(),
          RSizedBox(height: 24),
          EditProfileButton(),
        ],
      ),
    );
  }
}
