import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOrder extends StatelessWidget {
  final CartItemEntity cartitem;

  const CustomOrder({super.key, required this.cartitem});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 319.w,
      height: 125.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white[70]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              child: CachedNetworkImage(
                width: 120.w,
                height: 109.h,
                fit: BoxFit.cover,
                imageUrl: cartitem.product?.imgCover ?? "",
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartitem.product?.title ?? "",
                    style: theme.textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${cartitem.product!.price} ${AppText.egp.tr()}",
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 5),
                  const Text("Order Number: #123456"),
                  const SizedBox(height: 10),
                  RSizedBox(
                    width: 152,
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                      ),
                      onPressed: () {},
                      child: Text(
                        AppText.trackOrder.tr(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                    ),
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
