import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_state.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_view_model.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchViewModel, SearchState>(
      builder: (BuildContext context, SearchState state) {
        switch (state) {
          case InitialSearchState():
            return   Center(
              child: Text(
                AppText.searchForAnyProductsYouWent.tr(),
                style: const TextStyle(color: AppColors.pink),
              ),
            );

          case SearchLoadingState():
            return const Center(child: CircularProgressIndicator());
          case SearchSuccessState():
            final products = state.products;
            if (products.isEmpty) {
              return   Center(
                child: Text(
                  AppText.noProductsFound.tr(),
                  style: const TextStyle(color: AppColors.pink),
                ),
              );
            }
            return GridView.builder(
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
            );
          case SearchFailureState():
            return const Center(
              child: Text(AppText.notFound, style: TextStyle(color: AppColors.pink)),
            );
          case SearchEmptyState():
            return   Center(
              child: Text(
                AppText.noProductsFoundForYourSearch.tr(),
                style: const TextStyle(color: AppColors.pink),
              ),
            );
        }
      },
    );
  }
}
