import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesSliverAppBar extends StatelessWidget {
  const CategoriesSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      expandedHeight: 85.h,
      flexibleSpace: FlexibleSpaceBar(
        background: RPadding(
          padding: REdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              const RSizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: AppText.search,
                      prefixIcon: Padding(
                        padding: REdgeInsetsDirectional.only(
                          start: 16,
                          end: 3.5,
                        ),
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
                      enabledBorderColor: AppColors.white[70],
                    ),
                  ),
                  const RSizedBox(width: 8),
                  Container(
                    padding: REdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.white[70]!),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: SvgPicture.asset(
                      AppIcons.filter,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              const RSizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
