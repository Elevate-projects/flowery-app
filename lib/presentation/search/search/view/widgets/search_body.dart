import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_animations.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_state.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_view_model.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flowery_app/utils/loaders/animation_loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<SearchViewModel, SearchState>(
      builder: (BuildContext context, SearchState state) {
        switch (state) {
          case InitialSearchState():
            return Center(
              child: RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  AppText.searchForAnyProductsYouWant.tr(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            );

          case SearchLoadingState():
            return const Center(child: CircularProgressIndicator());
          case SearchSuccessState():
            final products = state.products;
            if (products.isEmpty) {
              return Center(
                child: RPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppText.noProductsFound.tr(),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              );
            }
            return RPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 17.r,
                  mainAxisSpacing: 17.r,
                  childAspectRatio: 1 / 1.44,
                ),
                itemCount: products.length,

                itemBuilder: (_, index) {
                  final product = products[index];
                  return ProductCardItem(productCardData: product);
                },
              ),
            );
          case SearchFailureState():
            return Center(
              child: RPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  state.error,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          case SearchEmptyState():
            return AnimationLoaderWidget(
              text: AppText.noProductsFoundForYourSearch,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
              animation: AppAnimations.emptyAnimation,
            );
        }
      },
    );
  }
}
