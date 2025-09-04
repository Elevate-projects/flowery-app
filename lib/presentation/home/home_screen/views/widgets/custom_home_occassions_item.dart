import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeOccasionsItem extends StatelessWidget {
  const CustomHomeOccasionsItem({super.key, required this.occasionsEntity});
  final OccasionEntity occasionsEntity;
  @override
  Widget build(BuildContext context) {
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
           imageUrl: occasionsEntity.image ?? "",
           errorWidget: (context, url, error) => const Icon(Icons.info),
           fit: BoxFit.fill,
           ),
         ),
       ),
        const RSizedBox(height: 8),
       Padding(
         padding:  REdgeInsetsDirectional.only(start: 14.0),
         child: RSizedBox(
          width: 130,
           child: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
             occasionsEntity.name ?? "",
             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               color: AppColors.black,
               fontWeight: FontWeight.w500
             ),
           ),
         ),
       ),
     ],
        );
  }
}