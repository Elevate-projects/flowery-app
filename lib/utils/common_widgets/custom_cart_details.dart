import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/cart/get_logged_user_cart/get_logged_user_cart.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCartDetails extends StatelessWidget {
  final CartItemEntity cartItem;

  const CustomCartDetails({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final product = cartItem.product;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: 343.w,
      height: 117.h,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            height: 101.h,
            width: 96.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                product?.imgCover ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.broken_image),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product?.title ?? AppText.noName,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.read<DeleteCartCubit>().doIntent(
                            DeleteCartItemIntent(
                              productId: cartItem.product?.id ?? "",
                              token: FloweryMethodHelper.currentUserToken ?? "",
                            ),
                          );
                        },
                        child: Image.asset(
                          AppIcons.trashIcon,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    product?.description ?? AppText.noDescription,
                    style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    children: [
                      Text(
                        "EGP ${cartItem.price ?? product?.price ?? 0}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if ((cartItem.quantity ?? 0) > 1) {
                            context.read<QuantityCubit>().doIntent(
                              UpdateCartQuantityIntent(
                                productId: cartItem.product?.id ?? "",
                                token:
                                FloweryMethodHelper.currentUserToken ??
                                    "",
                                quantity: (cartItem.quantity ?? 0) -1,
                              ),
                            );
                          }
                        },
                        child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      BlocBuilder<QuantityCubit, QuantityState>(
                        builder: (context, state) {
                          final isLoading = state.quantityStatus.isLoading &&
                              state.currentProductId == cartItem.product?.id;
                          return SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                                  : Text(
                                "${cartItem.quantity ?? 0}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<QuantityCubit>().doIntent(
                            UpdateCartQuantityIntent(
                              productId: cartItem.product?.id ?? "",
                              token:
                              FloweryMethodHelper.currentUserToken ?? "",
                              quantity: (cartItem.quantity ?? 0) + 1,
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 30.w,
                          height: 30.h,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
