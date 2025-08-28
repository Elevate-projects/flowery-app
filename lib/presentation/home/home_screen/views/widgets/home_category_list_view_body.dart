import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/custom_home_category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCategoryListViewBody extends StatelessWidget {
  const HomeCategoryListViewBody( {
    super.key,
  });

  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RSizedBox(
      height: 134,
      width: 1.sw,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppText.categoriesText,
              style: theme.textTheme.headlineSmall,),
              Text(AppText.viewAll,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.pink,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: Colors.pink,
              ),)
            ],
          ),
          const RSizedBox(height: 16,),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
             return const CustomHomeCategoryItem();
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,),
          )
        ],
      ),
    );
  }
}