import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/home/home_screen/view_model/home_products_cubit.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/custom_home_occassions_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeOccassionsListViewBody extends StatelessWidget {
  const HomeOccassionsListViewBody({super.key});

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
                AppText.occasionsText.tr(),
                style: theme.textTheme.headlineSmall,
              ),
              Text(
                AppText.viewAll.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.pink,
                  fontSize: 12.sp,
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
                    return CustomHomeOccasionsItem(
                      occasionsEntity: state.homeState.data!.occasions![index],
                    );
                  },
                  itemCount: state.homeState.data!.occasions!.length,
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
