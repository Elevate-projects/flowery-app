import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_intents.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_view_body.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.profileCubit});
  final ProfileCubit profileCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditProfileCubit>(
      create: (context) =>
          getIt.get<EditProfileCubit>()
            ..doIntent(intent: InitializedEditProfileIntent()),
      child: Scaffold(
        body: SafeArea(child: EditProfileViewBody(profileCubit: profileCubit)),
      ),
    );
  }
}
