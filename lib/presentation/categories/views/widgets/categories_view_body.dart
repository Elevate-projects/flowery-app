import 'package:flowery_app/presentation/categories/views/widgets/categories_sliver_app_bar.dart';
import 'package:flowery_app/presentation/categories/views/widgets/categories_tab_bar.dart';
import 'package:flowery_app/presentation/categories/views/widgets/categories_tab_bar_view.dart';
import 'package:flowery_app/presentation/categories/views/widgets/shimmer/categories_grid_view_shimmer.dart';
import 'package:flowery_app/presentation/categories/views/widgets/shimmer/categories_tab_bar_shimmer.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_cubit.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_state.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesViewBody extends StatelessWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listenWhen: (previous, current) =>
          current.productsStatus.isFailure ||
          current.categoriesStatus.isFailure,
      listener: (context, state) {
        if (state.categoriesStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.categoriesStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.productsStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.productsStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      buildWhen: (previous, current) =>
          current.categoriesStatus.isLoading ||
          current.categoriesStatus.isSuccess ||
          current.productsStatus.isLoading ||
          current.productsStatus.isSuccess,
      builder: (context, state) {
        if (state.categoriesStatus.isSuccess &&
            state.productsStatus.isSuccess) {
          return DefaultTabController(
            length: state.selectedCategories.length,
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                const CategoriesSliverAppBar(),
                CategoriesTabBar(categoriesTabs: state.selectedCategories),
              ],
              body: const CategoriesTabBarView(),
            ),
          );
        } else {
          return NestedScrollView(
            headerSliverBuilder: (context, _) => const [
              CategoriesSliverAppBar(),
              CategoriesTabBarShimmer(),
            ],
            body: const CategoriesGridViewShimmer(),
          );
        }
      },
    );
  }
}
