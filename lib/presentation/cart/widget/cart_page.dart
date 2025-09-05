import 'dart:developer';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_state.dart';
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
    log('userinfo: ${FloweryMethodHelper.userData}');
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: const CustomBackArrow(),
        title: const Text(AppText.cart),
      ),
      body: BlocListener<DeleteCartCubit, DeleteCartState>(
        listener: (context, state) {
          if (state.deleteStatus.isSuccess) {
            context.read<CartCubit>().doIntent(
              LoadCartIntent(FloweryMethodHelper.currentUserToken ?? ""),
            );
          }
        },
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state.cartStatus.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.cartStatus.isFailure) {
              return Center(
                child: Text(
                  state.cartStatus.error?.message ?? AppText.unexpectedError,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (state.cartStatus.isSuccess) {
              final cart = state.cartStatus.data;
              final cartItems = cart?.cart?.cartItems ?? [];

              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        SizedBox(width: 8),
                        Text(
                          AppText.delivery,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            AppText.location,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10),
                        ImageIcon(
                          AssetImage(AppIcons.arrowBackCart),
                          color: Colors.black45,
                          size: 28,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Text(AppText.subTotal, style: TextStyle(color: Colors.grey)),
                            const Spacer(),
                            Text(
                              "\$${cart?.cart?.totalPrice ?? 0}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Text(AppText.deliveryFee, style: TextStyle(color: Colors.grey)),
                            Spacer(),
                            Text("\$10", style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          children: [
                            const Text(
                              AppText.total,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "\$${(cart?.cart?.totalPrice ?? 0) + 10}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
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
                              backgroundColor: Colors.pinkAccent,
                            ),
                            child: const Text(
                              AppText.checkOut,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
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
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
