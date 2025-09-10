import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/about_us/views/widgets/about_us_app_bar.dart';
import 'package:flowery_app/presentation/about_us/views/widgets/about_us_view_body.dart';
import 'package:flowery_app/presentation/about_us/views_model/about_us_cubit.dart';
import 'package:flowery_app/presentation/about_us/views_model/about_us_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutUsCubit>(
      create: (context) =>
          getIt.get<AboutUsCubit>()
            ..doIntent(intent: AboutUsInitializationIntent()),
      child: const Scaffold(appBar: AboutUsAppBar(), body: AboutUsViewBody()),
    );
  }
}
