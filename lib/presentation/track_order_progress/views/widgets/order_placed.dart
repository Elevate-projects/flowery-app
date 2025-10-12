import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_images.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: RPadding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const RSizedBox(height: 100),
            Image.asset(
              AppImages.orderPlaced,
              fit: BoxFit.contain,
              height: 150.h,
            ),
            const RSizedBox(height: 56),
            Text(
              AppText.orderPlacedMessage.tr(),
              style: theme.textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
