import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesTabBar extends StatelessWidget {
  const CategoriesTabBar({super.key, required this.categoriesTabs});
  final List<String> categoriesTabs;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      toolbarHeight: 54.h,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              dividerHeight: 0,
              padding: REdgeInsets.symmetric(horizontal: 16),
              labelPadding: REdgeInsetsDirectional.only(end: 24),
              physics: const BouncingScrollPhysics(),
              splashFactory: NoSplash.splashFactory,
              labelStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.primary,
              ),
              unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.white[70],
              ),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: categoriesTabs
                  .map((category) => Tab(child: Text(category)))
                  .toList(),
            ),
            const RSizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
