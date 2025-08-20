import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/splash/views/widgets/splash_view_body.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_cubit.dart';
import 'package:flowery_app/presentation/splash/views_model/splash_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<SplashCubit>(
      create: (context) =>
          getIt.get<SplashCubit>()..doIntent(intent: GetUserDataIntent()),
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        body: const SplashViewBody(),
      ),
    );
  }
}
