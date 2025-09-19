import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_images.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/home/home_screen/views/widgets/custom_search_text_field.dart';
import 'package:flowery_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomAppBar(
      isTitleWidget: true,
      titleWidget: RPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.lightPink,
                borderRadius: BorderRadius.all(Radius.circular(18)),
              ),
              height: 20,
              width: 20,
              child: const Image(image: AssetImage(AppImages.floweryLogo)),
            ),
            Text(
              AppText.flowery.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w400,
                fontFamily: 'IM Fell English',
              ),
            ),
            const RSizedBox(width: 17),
            const Expanded(child: CustomSearchTextField()),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
