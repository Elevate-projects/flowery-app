import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/categories/views/widgets/categories_view_body.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_cubit.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<CategoriesCubit>()
            ..doIntent(intent: CategoriesInitializationIntent()),
      child: const SafeArea(child: CategoriesViewBody()),
    );
  }
}
