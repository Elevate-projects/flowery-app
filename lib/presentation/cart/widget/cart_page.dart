import 'dart:developer';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_state.dart';
import 'package:flowery_app/presentation/cart/widget/custom_cart_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flowery_app/utils/common_widgets/custom_cart_details.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  final String? productId;
  const CartPage({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    log('userinfo: ${FloweryMethodHelper.userData}');
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
          leading: const CustomBackArrow(),
        title: const Text(AppText.cart),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CartCubit, CartState>(
            listener: (context, state) {
              if (state.cartStatus.isFailure) {
                final errorMessage = state.cartStatus.error?.message ?? "";
                if (errorMessage ==   AppText.noToken) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(AppText.noToken),
                      backgroundColor: theme.colorScheme.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              }
            },
          ),
          BlocListener<DeleteCartCubit, DeleteCartState>(
            listener: (context, state) {
              if (state.deleteStatus.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: theme.colorScheme.onSurface,
                    content: Row(
                      children: [
                        Icon(Icons.check_circle_outline, color: theme.colorScheme.onSecondary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            AppText.delete,
                            style: TextStyle(color: theme.colorScheme.onSecondary,fontWeight: theme.textTheme.bodyMedium?.fontWeight),
                          ),
                        ),
                      ],
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
                context.read<CartCubit>().doIntent(
                  LoadCartIntent(),
                );
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
                  style: const TextStyle(color: AppColors.red),
                ),
              );
            }
            if (state.cartStatus.isSuccess) {
              final cart = state.cartStatus.data;
              final cartItems = cart?.cart?.cartItems ?? [];
              if (cartItems.isEmpty) {
                return  const Center(
                  child: Text(
                    AppText.noItems,
                    style: TextStyle(color: AppColors.black),
                  ),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(width: 8),
                        Text(
                          AppText.delivery,
                          style: TextStyle(
                            fontSize: theme.textTheme.bodyMedium?.fontSize,
                            color: AppColors.gray,
                          ),
                        ),
                        const SizedBox(width: 10),
                         Expanded(
                          child: Text(
                            AppText.location,
                            style: TextStyle(
                              fontSize: theme.textTheme.bodyMedium?.fontSize,
                              color: AppColors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                         ImageIcon(
                          const AssetImage(AppIcons.arrowBackCart),
                          color: AppColors.black.withAlpha(2),
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return CustomCartDetails(cartItem: item);
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(color: AppColors.white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                             const Text(
                              AppText.subTotal,
                              style: TextStyle(color: AppColors.gray),
                            ),
                            const Spacer(),
                            Text(
                              "\$${cart?.cart?.totalPrice ?? 0}",
                              style: const TextStyle(color: AppColors.gray),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                         const Row(
                          children: [
                             Text(
                              AppText.deliveryFee,
                              style: TextStyle(color: AppColors.gray),
                            ),
                            Spacer(),
                            Text("\$10", style: TextStyle(color: AppColors.gray)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                             Text(
                              AppText.total,
                              style: TextStyle(
                                fontSize: theme.textTheme.bodyLarge?.fontSize,
                                color: AppColors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "\$${(cart?.cart?.totalPrice ?? 0) + 10}",
                              style:  TextStyle(
                                fontSize: theme.textTheme.titleMedium?.fontSize,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle checkout button press
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.primary,
                            ),
                            child:  Text(
                              AppText.checkOut,
                              style: TextStyle(
                                fontSize: theme.textTheme.titleLarge?.fontSize,
                                color: AppColors.white,
                              ),
                            ),
                          ),
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
