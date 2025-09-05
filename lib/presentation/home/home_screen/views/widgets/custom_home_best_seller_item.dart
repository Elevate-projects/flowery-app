import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeBestSellerItem extends StatelessWidget {
  const CustomHomeBestSellerItem({super.key, required this.bestSellerEntity});
  final ProductCardEntity bestSellerEntity;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: RSizedBox(
            width: 131.w,
            height: 151.h,
            child: CachedNetworkImage(
              imageUrl: bestSellerEntity.imgCover ?? "",
              progressIndicatorBuilder: (context, url, progress) =>
                  ShimmerEffect(width: 131.w, height: 151.h),
              errorWidget: (context, url, error) => const Icon(Icons.info),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const RSizedBox(height: 8),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RSizedBox(
                width: 121,
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  bestSellerEntity.title ?? "",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppColors.black,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Text(
                "${bestSellerEntity.price} egp",
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
