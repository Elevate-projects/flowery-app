import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/home/best_seller/view/widgets/best_seller_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerView extends StatefulWidget {
  const BestSellerView({super.key});

  @override
  State<BestSellerView> createState() => _BestSellerViewState();
}

class _BestSellerViewState extends State<BestSellerView> {
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
      body: BestSellerList(),
    );
  }
}
