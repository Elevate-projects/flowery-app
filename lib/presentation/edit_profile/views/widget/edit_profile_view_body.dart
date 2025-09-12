import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_app_bar.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_details.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileViewBody extends StatelessWidget {
  const EditProfileViewBody({super.key, required this.profileCubit});
  final ProfileCubit profileCubit;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listenWhen: (previous, current) =>
          current.editProfileState.isSuccess ||
          current.uploadPhotoState.isSuccess,
      listener: (context, state) async {
        if (state.uploadPhotoState.isSuccess) {
          profileCubit.doIntent(intent: GetUserProfileDataIntent());
        } else if (state.editProfileState.isSuccess) {
          Navigator.of(context).pop();
          profileCubit.doIntent(intent: GetUserProfileDataIntent());
        }
      },
      child: const RPadding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EditProfileAppBar(),
            RSizedBox(height: 27),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [EditProfileDetails()]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
