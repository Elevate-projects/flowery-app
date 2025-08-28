import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHomeBestSellerItem extends StatelessWidget {
  const CustomHomeBestSellerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisSize: MainAxisSize.min,
     crossAxisAlignment: CrossAxisAlignment.start,
     children: [
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 16),
         child: SizedBox(
           width: 131.w,
           height: 151.h,
           child: const Image(
             image: AssetImage("assets/images/flowery_logo.png"),
           ),
         ),
       ),
       const RSizedBox(height: 8),
        Text(
         "Category",
         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
           color: AppColors.black,
           fontSize: 12.sp
         ),
         textAlign: TextAlign.center,
       ),
       Text(
         "600 egp",
         style: Theme.of(context).textTheme.bodyLarge?.copyWith(
           color: AppColors.black,
           fontWeight: FontWeight.w500
         ),
         textAlign: TextAlign.center,
       ),
     ],
        );
  }
}