import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/categories/views/widgets/categories_filter_content.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_cubit.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesFilter extends StatelessWidget {
  const CategoriesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) => GestureDetector(
        onTap: state.categoriesProductsList.isEmpty
            ? () {}
            : () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: theme.colorScheme.secondary,
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: categoriesCubit,
                    child: const CategoriesFilterContent(),
                  ),
                );
              },
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: 18.5, vertical: 9.5),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.filter2, fit: BoxFit.contain),
              const RSizedBox(width: 12),
              Text(
                AppText.filter.tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
