import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_cubit.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/shimmer/custom_home_best_seller_item_shimmer.dart';

class HomeBestSellerListViewBodyShimmer extends StatelessWidget {
  const HomeBestSellerListViewBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RSizedBox(
      height: 260,
      width: 1,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppText.bestSellerText,
                style: theme.textTheme.headlineSmall,
              ),
              Text(
                AppText.viewAll,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.pink,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.pink,
                ),
              ),
            ],
          ),
          const RSizedBox(height: 16),
          BlocBuilder<HomeProductsCubit, HomeProductsState>(
            builder: (context, state) {
              return RSizedBox(
                height: 216,
                width: 344,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return  const CustomHomeBestSellerItemShimmer();
                  },
                  itemCount: 14,
                  scrollDirection: Axis.horizontal,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
