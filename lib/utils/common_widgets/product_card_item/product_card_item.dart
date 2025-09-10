import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/add_to_cart_button.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_title_and_price.dart';
import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem({super.key, required this.productCardData});
  final ProductCardEntity productCardData;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.of(
        context,
      ).pushNamed(RouteNames.productDetails, arguments: productCardData),
      borderRadius: BorderRadius.circular(8.r),
      splashColor: theme.colorScheme.primary.withValues(alpha: 0.2),
      highlightColor: theme.colorScheme.primary.withValues(alpha: 0.2),
      child: Container(
        width: 163.w,
        height: 229.h,
        padding: REdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColors.white[70]!, width: 0.5.w),
          boxShadow: [
            BoxShadow(
              color: AppColors.white[70]!.withValues(alpha: 0.4),
              blurStyle: BlurStyle.outer,
              blurRadius: 6.r,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: REdgeInsets.symmetric(horizontal: 27.5, vertical: 2.5),
              height: 131.h,
              color: theme.colorScheme.onPrimary,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: productCardData.imgCover ?? "",
                  height: 131.h,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.info_outline)),
                  progressIndicatorBuilder: (context, url, progress) =>
                      ShimmerEffect(width: 92.w, height: 131.h, radius: 0),
                ),
              ),
            ),
            ProductTitleAndPrice(productCardData: productCardData),
            Flexible(
              child: AddToCartButton(
                productId: productCardData.productId ?? "",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
