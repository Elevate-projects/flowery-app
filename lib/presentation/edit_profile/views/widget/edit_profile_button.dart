import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_intents.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EditProfileCubit>(context);

    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        if (state.editProfileState.isLoading) {
          return const LoadingButton();
        }
        return CustomElevatedButton(
          onPressed: () async {
            await controller.doIntent(intent: EditProfileWithDataIntent());
          },
          buttonTitle: AppText.editProfileUpdateButton,
        );
      },
    );
  }
}
