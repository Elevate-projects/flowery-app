import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/checkout_common_widgets/custom_add_naw_address.dart';
import 'package:flowery_app/utils/common_widgets/checkout_common_widgets/custom_checkout_summary.dart';
import 'package:flowery_app/utils/common_widgets/checkout_common_widgets/custom_delivery_address.dart';
import 'package:flowery_app/utils/common_widgets/checkout_common_widgets/custom_divider.dart';
import 'package:flowery_app/utils/common_widgets/checkout_common_widgets/custom_gift_section.dart';
import 'package:flowery_app/utils/common_widgets/custom_paymant.dart';
import 'package:flowery_app/utils/common_widgets/custom_payment_vise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutViewBody extends StatelessWidget {
  final int subTotal;
  const CheckoutViewBody({
    super.key,
     required this.subTotal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.zero,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(AppText.checkout.tr()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RSizedBox(height: 10),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      AppText.deliveryTime.tr(),
                      style: theme.textTheme.headlineSmall,
                    ),
                    const Spacer(),
                    Text(
                      AppText.schedule.tr(),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const RSizedBox(height: 10),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const ImageIcon(AssetImage(AppIcons.clock)),
                    const RSizedBox(width: 10),
                    Text(
                      AppText.instant.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    Text(
                      AppText.instantArrive.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const RSizedBox(height: 15),
              const CustomDivider(),
              const RSizedBox(height: 10),
              const CustomDeliveryAddress(),
              const RSizedBox(height: 5),
              CustomAddAddressButton(
                onPressed: () {
                  /////Action here
                },
              ),
              const RSizedBox(height: 20),
              const CustomDivider(),
              const RSizedBox(height: 20),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  AppText.payment.tr(),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const RSizedBox(height: 10),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 10),
                child: const Column(
                  children: [
                    CustomPayment(),
                    RSizedBox(height: 10),
                    CustomPaymentVise(),
                  ],
                ),
              ),
              const RSizedBox(height: 15),
              const CustomDivider(),
              const RSizedBox(height: 10),
              const CustomGiftSection(),
              const RSizedBox(height: 10),
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CustomCheckoutSummary(
                      subTotal: subTotal.toDouble(),
                      onPlaceOrder: () {
                        /////Action here
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}