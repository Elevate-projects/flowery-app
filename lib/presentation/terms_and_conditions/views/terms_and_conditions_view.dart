import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views/widgets/terms_and_conditions_app_bar.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views/widgets/terms_and_conditions_view_body.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views_model/terms_and_conditions_cubit.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views_model/terms_and_conditions_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TermsAndConditionsCubit>(
      create: (context) =>
          getIt.get<TermsAndConditionsCubit>()
            ..doIntent(intent: TermsAndConditionsInitializationIntent()),
      child: const Scaffold(
        appBar: TermsAndConditionsAppBar(),
        body: TermsAndConditionsViewBody(),
      ),
    );
  }
}
