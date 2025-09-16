import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckoutSummary extends StatelessWidget {
  final double subTotal;
  final VoidCallback onPlaceOrder;
  final String deliveryFee;

  const CustomCheckoutSummary({
    super.key,
    required this.subTotal,
    this.deliveryFee = "10",
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double fee = double.parse(deliveryFee);
    final double total = subTotal + fee;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppText.subTotal.tr(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.shadow,
              ),
            ),
            const Spacer(),
            Text(
              "\$${subTotal.toInt()}",
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.shadow,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Text(
              AppText.deliveryFee.tr(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.shadow,
              ),
            ),
            const Spacer(),
            Text(
              "\$${fee.toInt()}",
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.shadow,
              ),
            ),
          ],
        ),

        Divider(color: theme.colorScheme.shadow, thickness: 1),
        const RSizedBox(height: 10),
        Row(
          children: [
            Text(
              AppText.total.tr(),
              style: theme.textTheme.headlineSmall,
            ),
            const Spacer(),
            Text(
              "\$${total.toInt()}",
              style: theme.textTheme.headlineSmall,
            ),
          ],
        ),
        const RSizedBox(height: 10),
        CustomElevatedButton(
          onPressed: onPlaceOrder,
          buttonTitle: AppText.placeOrder.tr(),
        ),

        const RSizedBox(height: 20),
      ],
    );
  }
}
