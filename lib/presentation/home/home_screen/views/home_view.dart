import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_cubit.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_intent.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/home_app_bar.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<HomeProductsCubit>()..doIntent(GetAllProductsIntent()),
      child: const Scaffold(appBar: HomeAppBar(), body: HomeViewBody()),
    );
  }
}
