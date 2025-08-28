import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/domain/entities/home_products/category_entity.dart';
import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeCategoryItem extends StatelessWidget {
  const CustomHomeCategoryItem({super.key, required this.categoryData});
  final CategoryEntity categoryData;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: 68.w,
            height: 64.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            padding: REdgeInsets.all(12),
            child: Center(
              child: RSizedBox(
                width: 24,
                height: 24,
                child: CachedNetworkImage(
                  imageUrl: categoryData.image ?? "",
                  progressIndicatorBuilder: (context, url, progress) =>
                      ShimmerEffect(width: 24.r, height: 24.r),
                  errorWidget: (context, url, error) => const Icon(Icons.info),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const RSizedBox(height: 8),
        Text(
          categoryData.name ?? "",
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
