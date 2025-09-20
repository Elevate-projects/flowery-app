import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/arguments/address_argument_entity.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/presentation/checkout/views/widgets/custom_add_naw_address.dart';
import 'package:flowery_app/presentation/checkout/views/widgets/custom_checkout_summary.dart';
import 'package:flowery_app/presentation/checkout/views/widgets/custom_delivery_address.dart';
import 'package:flowery_app/presentation/checkout/views/widgets/custom_divider.dart';
import 'package:flowery_app/presentation/checkout/views/widgets/custom_gift_section.dart';
import 'package:flowery_app/presentation/checkout/views/widgets/custom_paymant.dart';
import 'package:flowery_app/presentation/checkout/views/widgets/custom_payment_vise.dart';
import 'package:flowery_app/presentation/checkout/views_model/address_cubit/address_cubit.dart';
import 'package:flowery_app/presentation/checkout/views_model/payment_cubit/payment_cubit.dart';
import 'package:flowery_app/presentation/payment/cash/view/cash_payment_view.dart';
import 'package:flowery_app/presentation/payment/credit/view/credit_payment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutViewBody extends StatelessWidget {
  final int subTotal;
  final List<CartItemEntity> cartItems;

  const CheckoutViewBody({
    super.key,
    required this.subTotal,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Stack(
      children: [
        CashPaymentView(cartItems: cartItems),
        CreditPaymentView(cartItems: cartItems),

        Scaffold(
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
                      Navigator.pushNamed(
                        context,
                        RouteNames.addressDetails,
                        arguments: AddressArgumentEntity(
                          isAddedFromCheckout: true,
                          addressCubit: addressCubit,
                        ),
                      );
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
                            context.read<PaymentCubit>().confirmOrder(
                              context: context,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
