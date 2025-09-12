import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_intent.dart';
import 'package:flowery_app/presentation/search/search/view_model/search_view_model.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: 60,
      title: CustomTextFormField(
        label: AppText.search.tr(),
        prefixIcon: Padding(
          padding: REdgeInsetsDirectional.only(start: 16, end: 3.5),
          child: SvgPicture.asset(
            AppIcons.search,
            fit: BoxFit.scaleDown,
            colorFilter: ColorFilter.mode(
              AppColors.white[70]!,
              BlendMode.srcIn,
            ),
          ),
        ),
        labelStyle: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
        ),

        borderRadius: 8.r,
        disabledBorderColor: AppColors.white[70],
        enabled: true,
        onChanged: (value) {
          context.read<SearchViewModel>().doIntent(
            OnSearchClick(search: value.trim()),
          );
        },
      ),
    );
  }
}
