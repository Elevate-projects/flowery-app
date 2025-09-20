import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductTitleAndPrice extends StatelessWidget {
  const ProductTitleAndPrice({super.key, required this.productCardData});
  final ProductCardEntity productCardData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RPadding(
      padding: REdgeInsets.symmetric(horizontal: 13.5, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productCardData.title ?? "",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const RSizedBox(height: 4),
          Row(
            children: [
              Flexible(
                flex: 4,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${AppText.egp.tr()} ${productCardData.priceAfterDiscount}",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ),
              ),
              const RSizedBox(width: 4),
              Flexible(
                flex: 3,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    productCardData.price.toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.shadow,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: theme.colorScheme.shadow,
                    ),
                  ),
                ),
              ),
              const RSizedBox(width: 4),
              Flexible(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    productCardData.discountPercentage.toString(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
