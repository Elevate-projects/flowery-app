import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_cubit.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/shimmer/custom_home_occassions_item_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeOccassionsListViewBodyShimmer extends StatelessWidget {
  const HomeOccassionsListViewBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RSizedBox(
      height: 232,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppText.occassionsText,
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
          Expanded(
            child: BlocBuilder<HomeProductsCubit, HomeProductsState>(
              builder: (context, state) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return const CustomHomeOccassionsItemShimmer();
                  },
                  itemCount: 14,
                  scrollDirection: Axis.horizontal,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
