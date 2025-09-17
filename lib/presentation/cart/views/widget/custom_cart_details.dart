import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_cubit.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_intent.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_state.dart';
import 'package:flowery_app/utils/common_widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCartDetails extends StatelessWidget {
  final CartItemEntity? cartItem;
  const CustomCartDetails({super.key, required this.cartItem});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = cartItem?.product;
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
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) => Column(
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
                          onTap:
                              (!state.quantityStatus.isLoading &&
                                  !state.deleteStatus.isLoading)
                              ? () async {
                                  await context.read<CartCubit>().doIntent(
                                    DeleteCartItemIntent(
                                      productId:
                                          cartItem?.product?.productId ?? "",
                                    ),
                                  );
                                }
                              : () {},
                          child: BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) =>
                                (state.deleteStatus.isLoading &&
                                    state.currentProductId ==
                                        product?.productId)
                                ? LoadingCircle(
                                    width: 18.r,
                                    height: 18.r,
                                    circleColor: theme.colorScheme.error,
                                  )
                                : Image.asset(
                                    AppIcons.trashIcon,
                                    width: 24.r,
                                    height: 24.r,
                                  ),
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
                        Expanded(
                          child: FittedBox(
                            alignment: AlignmentDirectional.centerStart,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${AppText.price.tr()}: ${product?.price ?? 0}",
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: theme.colorScheme.onSecondary,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              (!state.quantityStatus.isLoading &&
                                  !state.deleteStatus.isLoading)
                              ? () async {
                                  if ((cartItem?.quantity ?? 0) > 1) {
                                    await context.read<CartCubit>().doIntent(
                                      UpdateCartQuantityIntent(
                                        productId:
                                            cartItem?.product?.productId ?? "",
                                        quantity: (cartItem?.quantity ?? 1) - 1,
                                      ),
                                    );
                                  }
                                }
                              : () {},
                          child: SizedBox(
                            width: 30.r,
                            height: 30.r,
                            child: Center(
                              child: BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) =>
                                    (state.isQuantityDecreased &&
                                        state.currentProductId ==
                                            product?.productId &&
                                        state.quantityStatus.isLoading)
                                    ? LoadingCircle(
                                        circleColor: theme.colorScheme.primary,
                                        height: 18.r,
                                        width: 18.r,
                                      )
                                    : Icon(
                                        Icons.remove,
                                        size: theme
                                            .textTheme
                                            .titleLarge
                                            ?.fontSize,
                                        color: theme.colorScheme.onSecondary,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const RSizedBox(width: 5),
                        RSizedBox(
                          width: 24.r,
                          height: 24.r,
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "${cartItem?.quantity ?? 0}",
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: theme.colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              (!state.quantityStatus.isLoading &&
                                  !state.deleteStatus.isLoading)
                              ? () async {
                                  await context.read<CartCubit>().doIntent(
                                    UpdateCartQuantityIntent(
                                      productId:
                                          cartItem?.product?.productId ?? "",
                                      quantity: (cartItem?.quantity ?? 1) + 1,
                                    ),
                                  );
                                }
                              : () {},
                          child: RSizedBox(
                            width: 30.r,
                            height: 30.r,
                            child: Center(
                              child: BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) =>
                                    (state.isQuantityIncreased &&
                                        state.currentProductId ==
                                            product?.productId &&
                                        state.quantityStatus.isLoading)
                                    ? LoadingCircle(
                                        circleColor: theme.colorScheme.primary,
                                        height: 18.r,
                                        width: 18.r,
                                      )
                                    : Icon(
                                        Icons.add,
                                        size: theme
                                            .textTheme
                                            .titleLarge
                                            ?.fontSize,
                                        color: theme.colorScheme.onSecondary,
                                      ),
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
          ),
        ],
      ),
    );
  }
}
