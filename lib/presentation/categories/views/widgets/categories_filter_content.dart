import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_cubit.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_intent.dart';
import 'package:flowery_app/presentation/categories/views_model/categories_state.dart';
import 'package:flowery_app/utils/common_widgets/bottom_sheet_selection_item.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CategoriesFilterContent extends StatelessWidget {
  const CategoriesFilterContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    return RPadding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 80.r,
              height: 4.r,
              decoration: BoxDecoration(
                color: theme.colorScheme.shadow,
                borderRadius: BorderRadius.circular(100.r),
              ),
            ),
          ),
          const RSizedBox(height: 16),
          Text(
            AppText.sortBy.tr(),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          const RSizedBox(height: 16),
          BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) => RadioGroup<String>(
              groupValue: state.selectedFilter,
              onChanged: (String? value) {
                categoriesCubit.doIntent(
                  intent: ChangeCategoryFilterIntent(
                    selectedFilter: value ?? AppText.lowestPrice,
                  ),
                );
              },
              child: Column(
                children: [
                  RSizedBox(
                    height: 375,
                    child: ListView.separated(
                      padding: REdgeInsets.all(2),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => BottomSheetSelectionItem(
                        itemTitle: categoriesCubit.filters[index].tr(),
                        radioItem: Radio<String>(
                          value: categoriesCubit.filters[index],
                          activeColor: theme.colorScheme.primary,
                          toggleable: true,
                        ),
                        onTap: () {
                          categoriesCubit.doIntent(
                            intent: ChangeCategoryFilterIntent(
                              selectedFilter: categoriesCubit.filters[index],
                            ),
                          );
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          const RSizedBox(height: 16),
                      itemCount: categoriesCubit.filters.length,
                    ),
                  ),
                  const RSizedBox(height: 16),
                  CustomElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    buttonTitle: "",
                    isText: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.filter2, fit: BoxFit.contain),
                        const RSizedBox(width: 12),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              AppText.filter.tr(),
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
