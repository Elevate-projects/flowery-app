import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_state.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_state.dart';
import 'package:flowery_app/presentation/cart/widget/custom_cart_shimmer.dart';
import 'package:flowery_app/utils/common_widgets/custom_cart_details.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  final String? productId;
  const CartPage({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(titleSpacing: 0, title: Text(AppText.cartPage.tr())),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state.cartStatus.isFailure) {
                final errorMessage = state.cartStatus.error?.message ?? "";
                if (errorMessage == AppText.noToken.tr()) {
                  Loaders.showErrorMessage(
                    message: AppText.noToken,
                    context: context,
                  );
                }
              }
            },
          ),
          BlocListener<DeleteCartCubit, DeleteCartState>(
            listener: (context, state) {
              if (state.deleteStatus.isSuccess) {
                Loaders.showSuccessMessage(
                  message: AppText.deleteCart.tr(),
                  context: context,
                );
                context.read<CartCubit>().doIntent(LoadCartIntent());
              }
            },
          ),
        ],
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.cartStatus.isLoading) {
              return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) =>
                    const CustomCartDetailsShimmer(),
              );
            }
            if (state.cartStatus.isFailure) {
              return Center(
                child: Text(
                  state.cartStatus.error?.message ?? AppText.unexpectedError,
                  style: theme.textTheme.bodySmall,
                ),
              );
            }
            if (state.cartStatus.isSuccess) {
              final cart = state.cartStatus.data;
              final cartItems = cart?.cart?.cartItems ?? [];
              if (cartItems.isEmpty) {
                return Center(
                  child: Text(
                    AppText.noItems.tr(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: REdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const RSizedBox(width: 8),
                        Text(
                          AppText.delivery.tr(),
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.shadow,
                          ),
                        ),
                        const RSizedBox(width: 10),
                        Expanded(
                          child: Text(
                            AppText.location.tr(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const RSizedBox(width: 10),
                        ImageIcon(
                          const AssetImage(AppIcons.arrowBackCart),
                          color: theme.colorScheme.onSecondary,
                          size: theme.textTheme.titleLarge?.fontSize,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: REdgeInsets.symmetric(horizontal: 8),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return CustomCartDetails(cartItem: item);
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: REdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                              "\$${cart?.cart?.totalPrice ?? 0}",
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.shadow,
                              ),
                            ),
                          ],
                        ),
                        const RSizedBox(height: 4),
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
                        const Divider(),
                        Row(
                          children: [
                            Text(
                              AppText.total.tr(),
                              style: theme.textTheme.headlineSmall,
                            ),
                            const Spacer(),
                            Text(
                              "\$${(cart?.cart?.totalPrice ?? 0) + 10}",
                              style: theme.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                        const RSizedBox(height: 10),
                        CustomElevatedButton(
                          onPressed: () {},
                          buttonTitle: AppText.checkOut,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
