import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_cubit.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/custom_home_best_seller_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBestSellerListViewBody extends StatelessWidget {
  const HomeBestSellerListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RSizedBox(
      height: 260,
      child: BlocBuilder<HomeProductsCubit, HomeProductsState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppText.bestSellerText.tr(),
                    style: theme.textTheme.headlineSmall,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.bestSeller,
                        arguments: state.homeState.data?.bestSeller,
                      );
                    },
                    child: Text(
                      AppText.viewAll.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.pink,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.pink,
                      ),
                    ),
                  ),
                ],
              ),
              const RSizedBox(height: 16),
              BlocBuilder<HomeProductsCubit, HomeProductsState>(
                builder: (context, state) {
                  return RSizedBox(
                    height: 216,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return CustomHomeBestSellerItem(
                          bestSellerEntity:
                              state.homeState.data!.bestSeller![index],
                        );
                      },
                      itemCount: state.homeState.data!.bestSeller!.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
