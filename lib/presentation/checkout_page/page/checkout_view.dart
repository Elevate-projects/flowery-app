import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/utils/common_widgets/custom_add_address.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/custom_paymant.dart';
import 'package:flowery_app/utils/common_widgets/custom_payment_vise.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutView extends StatelessWidget {
  final CartItemEntity cartItem;
  final int subTotal;
  const CheckoutView({
    super.key,
    required this.cartItem,
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
          padding:  REdgeInsets.only(bottom: 20),
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
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  AppText.deliveryAddress.tr(),
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const RSizedBox(height: 10),
              /////////////////////////////////////
              ListView.builder(
                itemCount: 2,
                padding: REdgeInsets.symmetric(horizontal: 8, vertical: 12),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const CustomAddAddress();
                },
              ),
              const RSizedBox(height: 5),
              Padding(
                //////////////////////////////////
                padding: REdgeInsets.symmetric(horizontal: 13),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: theme.colorScheme.shadow),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      backgroundColor: theme.colorScheme.secondary,
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const RSizedBox(width: 5),
                        Text(AppText.addAddress.tr()),
                        const Icon(Icons.add),
                      ],
                    ),
                  ),
                ),
              ),
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
              const RSizedBox(height: 10),
              Padding(
                padding:  REdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Switch.adaptive(
                        value: false,
                        onChanged: (value) {
                        },
                        padding: EdgeInsets.zero,
                        activeThumbColor: theme.colorScheme.secondary,
                        activeTrackColor: theme.colorScheme.primary,
                      ),
                    ),
                    const RSizedBox(width: 10),
                    Text(AppText.itsGift.tr(), style: theme.textTheme.headlineSmall),
                  ],
                ),
              ),
              const RSizedBox(height: 5),
              Padding(
                padding:  REdgeInsets.symmetric(horizontal: 10),
                child: CustomTextFormField(
                  label: AppText.name.tr(),
                  hintText: AppText.enterName.tr(),
                ),
              ),
              const RSizedBox(height: 10),
               Padding(
                padding: REdgeInsets.symmetric(horizontal: 10),
                child: CustomTextFormField(
                  label: AppText.phoneNumber.tr(),
                  hintText: AppText.enterPhoneNumber.tr(),
                ),
              ),
              const RSizedBox(height: 10),
              Padding(
                padding:  REdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    /// sub total
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
                          "\$$subTotal",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.shadow,
                          ),
                        ),
                      ],
                    ),
                    const RSizedBox(height: 10),
                    /// delivery fee
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
                          "\$10",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.shadow,
                          ),
                        ),
                      ],
                    ),
                    Divider(color: theme.colorScheme.shadow, thickness: 1),
                    const RSizedBox(height: 10,),
                    /// total
                    Row(
                      children: [
                        Text(
                          AppText.total.tr(),
                          style: theme.textTheme.headlineSmall,
                        ),
                        const Spacer(),
                        Text(
                          "\$${subTotal + 10}",
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const RSizedBox(height: 10),
                    CustomElevatedButton(
                      onPressed: () {},
                      buttonTitle: AppText.placeOrder.tr(),
                    ),
                    const RSizedBox(height: 20),
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
