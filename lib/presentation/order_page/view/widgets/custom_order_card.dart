import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOrder extends StatelessWidget {
  final OrderEntity order;
  final bool isCompleted;
  const CustomOrder({super.key, required this.order, this.isCompleted = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstItem = order.orderItems?.isNotEmpty == true
        ? order.orderItems!.first
        : null;
    final product = firstItem?.product;

    return Container(
      width: 319.w,
      height: 125.h,
      padding: REdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white[70]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          ClipRRect(
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
          const RSizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    product?.title ?? "",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const RSizedBox(height: 5),
                if (firstItem != null)
                  Text(
                    "${AppText.egp.tr()} ${firstItem.price ?? 0}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                const RSizedBox(height: 5),
                Text(
                  "${AppText.orderNumber.tr()} ${order.orderNumber ?? ''}",
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.shadow,
                  ),
                ),
                Visibility(
                  visible: !isCompleted,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RSizedBox(height: 10),
                      RSizedBox(
                        width: 152,
                        height: 30,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              RouteNames.trackOrderProgress,
                              arguments: order.id,
                            );
                          },
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
