import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/profile/views/widgets/profile_view_body.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) =>
          getIt.get<ProfileCubit>()
            ..doIntent(intent: ProfileInitializationIntent()),
      child: const SafeArea(child: ProfileViewBody()),
    );
  }
}
