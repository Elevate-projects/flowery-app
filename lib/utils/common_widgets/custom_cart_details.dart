import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
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
      margin: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            margin: REdgeInsets.symmetric(horizontal: 8),
            height: 101.h,
            width: 96.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: product?.imgCover ?? '',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
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
                  const RSizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product?.title ?? AppText.noName.tr(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onSecondary,
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
                          width: 24.r,
                          height: 24.r,
                        ),
                      ),
                    ],
                  ),
                  const RSizedBox(height: 3),
                  Text(
                    product?.description ?? AppText.noDescription.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.shadow,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const RSizedBox(height: 17),
                  Row(
                    children: [
                      Text(
                        "${AppText.price.tr()}: ${product?.price ?? 0}",
                        style: theme.textTheme.titleMedium?.copyWith(
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
                          width: 30.r,
                          height: 30.r,
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: theme.textTheme.titleLarge?.fontSize,
                              color: theme.colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                      const RSizedBox(width: 5),
                      BlocBuilder<QuantityCubit, QuantityState>(
                        builder: (context, state) {
                          final isLoading =
                              state.quantityStatus.isLoading &&
                              state.currentProductId ==
                                  cartItem.product?.productId;
                          return RSizedBox(
                            width: 24.r,
                            height: 24.r,
                            child: Center(
                              child: isLoading
                                  ? RSizedBox(
                                      width: 16.r,
                                      height: 16.r,
                                      child: const CircularProgressIndicator(),
                                    )
                                  : Text(
                                      "${cartItem.quantity ?? 0}",
                                      style: theme.textTheme.headlineSmall
                                          ?.copyWith(
                                            color:
                                                theme.colorScheme.onSecondary,
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
                        child: RSizedBox(
                          width: 30.r,
                          height: 30.r,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: theme.textTheme.titleLarge?.fontSize,
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
