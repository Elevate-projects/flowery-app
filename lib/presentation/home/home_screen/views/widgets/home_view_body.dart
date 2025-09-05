import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_cubit.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/home_best_seller_list_view_body.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/home_category_list_view_body.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/home_occassions_list_view_body.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/location_selector.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/shimmer/home_best_seller_list_view_body_shimmer.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/shimmer/home_category_list_view_body_shimmer.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/shimmer/home_occassions_list_view_body_shimmer.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeProductsCubit, HomeProductsState>(
      listenWhen: (previous, current) {
        return current.homeState.isSuccess || current.homeState.isFailure;
      },
      listener: (context, state) {
        if (state.homeState.isFailure) {
          Loaders.showErrorMessage(
            message: state.homeState.error?.message ?? "",
            context: context,
          );
        }
      },
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LocationSelector(),
                  const RSizedBox(height: 16),
                  BlocBuilder<HomeProductsCubit, HomeProductsState>(
                    builder: (context, state) => state.homeState.isLoading
                        ? const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeCategoryListViewBodyShimmer(),
                              RSizedBox(height: 24),
                              HomeBestSellerListViewBodyShimmer(),
                              RSizedBox(height: 24),
                              HomeOccassionsListViewBodyShimmer(),
                            ],
                          )
                        : const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HomeCategoryListViewBody(),
                              RSizedBox(height: 24),
                              HomeBestSellerListViewBody(),
                              RSizedBox(height: 24),
                              HomeOccassionsListViewBody(),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
