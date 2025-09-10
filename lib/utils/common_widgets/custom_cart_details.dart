import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_Item_entity.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class CustomCartDetails extends StatelessWidget {
  final CartItemEntity cartItem;
  const CustomCartDetails({super.key, required this.cartItem});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = cartItem.product;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: 343.w,
      height: 117.h,
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.onSecondary),
        color: theme.colorScheme.secondary,
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
                            fontSize: theme.textTheme.titleSmall?.fontSize,
                            color: theme.colorScheme.shadow,
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
                              productId: cartItem.product?.productId ?? "",
                            ),
                          );
                        },
                        child: Image.asset(
                          AppIcons.trashIcon,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    product?.description ?? AppText.noDescription,
                    style: TextStyle(fontSize: theme.textTheme.bodySmall?.fontSize, color:
                    theme.colorScheme.shadow),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    children: [
                      Text(
                        "EGP ${cartItem.price ?? product?.price ?? 0}",
                        style: TextStyle(
                          fontSize: theme.textTheme.titleMedium?.fontSize,
                          fontWeight: theme.textTheme.titleMedium?.fontWeight,
                          color: theme.colorScheme.onSecondary,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if ((cartItem.quantity ?? 0) > 1) {
                            context.read<QuantityCubit>().doIntent(
                              UpdateCartQuantityIntent(
                                productId: cartItem.product?.productId ?? "",
                                quantity: (cartItem.quantity ?? 0) - 1,
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
                              size: theme.textTheme.titleLarge?.fontSize,
                              color: theme.colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      BlocBuilder<QuantityCubit, QuantityState>(
                        builder: (context, state) {
                          final isLoading =
                              state.quantityStatus.isLoading &&
                              state.currentProductId == cartItem.product?.productId;
                          return SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Center(
                              child: isLoading
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      "${cartItem.quantity ?? 0}",
                                      style: TextStyle(
                                        fontSize: theme.textTheme.titleMedium?.fontSize,
                                        fontWeight: theme.textTheme.titleMedium?.fontWeight,
                                        color: theme.colorScheme.onSecondary,
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
                              productId: cartItem.product?.productId ?? "",
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
                              color: theme.colorScheme.onSecondary,
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
