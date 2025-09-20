import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/categories/views/widgets/categories_filter.dart';
import 'package:flowery_app/presentation/categories/views/widgets/categories_view_body.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_cubit.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_intent.dart';
import 'package:flowery_app/utils/common_cubits/add_product_to_cart/add_product_to_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesCubit>(
          create: (context) =>
              getIt.get<CategoriesCubit>()
                ..doIntent(intent: CategoriesInitializationIntent()),
        ),
        BlocProvider<AddProductToCartCubit>(
          create: (context) => getIt.get<AddProductToCartCubit>(),
        ),
      ],
      child: const Scaffold(
        floatingActionButton: CategoriesFilter(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(child: CategoriesViewBody()),
      ),
    );
  }
}
