import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouteNames.searchView);
      },
      child: RSizedBox(
        height: 36,
        child: CustomTextFormField(
          label: AppText.search,
          labelStyle: theme.textTheme.bodyLarge?.copyWith(
            color: AppColors.white[70],
          ),
          keyboardType: TextInputType.text,
          prefixIcon: Padding(
            padding: REdgeInsetsDirectional.only(start: 8),
            child: SvgPicture.asset(
              AppIcons.search,
              colorFilter: ColorFilter.mode(
                AppColors.white[70]!,
                BlendMode.srcIn,
              ),
            ),
          ),
          borderRadius: 8.r,
          enabled: false,
          disabledBorderColor: AppColors.white[70],
        ),
      ),
    );
  }
}
