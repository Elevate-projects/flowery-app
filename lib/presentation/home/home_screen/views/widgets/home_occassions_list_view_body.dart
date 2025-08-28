import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/custom_home_occassions_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeOccassionsListViewBody extends StatelessWidget {
  const HomeOccassionsListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RSizedBox(
      height: 222,
      width: 1.sw,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppText.occassionsText,
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
             return const CustomHomeOccasionsItem();
            },
            itemCount: 10,
            scrollDirection: Axis.horizontal,),
          )
        ],
      ),
    );
  }
}