import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/home/best_seller/view/widgets/best_seller_list.dart';
import 'package:flowery_app/presentation/home/best_seller/view_model/best_seller_cubit.dart';
import 'package:flowery_app/presentation/home/best_seller/view_model/best_seller_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_model/best_seller_intent.dart';

class BestSellerView extends StatefulWidget {
  const BestSellerView({super.key});

  @override
  State<BestSellerView> createState() => _BestSellerViewState();
}

class _BestSellerViewState extends State<BestSellerView> {
  @override
  void initState() {
    BlocProvider.of<BestSellerCubit>(context).doIntent(LoadBestSellerIntent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.bestSellerAppbar,
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(height: 4.h),
            Text(
              AppText.bestSellerAppbarHint,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.gray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: BlocBuilder<BestSellerCubit, BestSellerState>(
        builder: (context, state) {
          switch (state.status) {
            case Status.initial:
              return const SizedBox();
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.success:
              return BestSellerList();
            case Status.error:
              return Center(
                child: Text(
                  state.exception?.message ?? 'Something went wrong',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.red,
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
