import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_intent.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_view_model.dart';
import 'package:flowery_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomAppBar(
      automaticallyImplyLeading: true,
      isTitleWidget: true,
      titleWidget: Padding(
        padding: REdgeInsetsDirectional.only(end: 16),
        child: RSizedBox(
          height: 42,
          child: CustomTextFormField(
            label: AppText.search,
            contentPadding: EdgeInsets.zero,
            prefixIcon: Padding(
              padding: REdgeInsetsDirectional.only(start: 16, end: 3.5),
              child: SvgPicture.asset(AppIcons.search, fit: BoxFit.scaleDown),
            ),
            labelStyle: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.w500,
            ),

            borderRadius: 8.r,
            onChanged: (value) {
              context.read<SearchViewModel>().doIntent(
                OnSearchClick(search: value.trim()),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
