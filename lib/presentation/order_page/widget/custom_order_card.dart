import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOrder extends StatelessWidget {
  final OrderEntity order;

  const CustomOrder({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstItem = order.orderItems?.isNotEmpty == true ? order.orderItems!.first : null;
    final product = firstItem?.product;

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
            padding: REdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                width: 120.w,
                height: 109.h,
                fit: BoxFit.cover,
                imageUrl: product?.imgCover ?? "",
                placeholder: (_, __) => Container(
                  color: theme.colorScheme.primary,
                  width: 120.w,
                  height: 109.h,
                ),
                errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
          ),
          const RSizedBox(width: 10),
          Padding(
            padding:  REdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.title ?? "",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const RSizedBox(height: 5),
                if (firstItem != null)
                  Text(
                    "${firstItem.price ?? 0} ${AppText.egp.tr()}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                const RSizedBox(height: 5),
                Text("Order Number: #${order.orderNumber ?? ''}"),
                const RSizedBox(height: 10),
                RSizedBox(
                  width: 152,
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    onPressed: () {
                      /// Action here
                    },
                    child: Text(
                      AppText.trackOrder.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
