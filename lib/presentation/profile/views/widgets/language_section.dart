import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_app/presentation/profile/views/widgets/language_item.dart';
import 'package:flowery_app/presentation/profile/views/widgets/profile_navigation_item.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_intent.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSection extends StatelessWidget {
  const LanguageSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profileCubit = BlocProvider.of<ProfileCubit>(context);
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) => ProfileNavigationItem(
        title: AppText.language,
        prefixIconPath: AppIcons.language,
        isSuffixArrow: false,
        suffixWidget: Text(
          state.selectedLanguage == Languages.arabic
              ? AppText.arabic.tr()
              : AppText.english.tr(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        onTap: () {
          showModalBottomSheet(
            backgroundColor: theme.colorScheme.secondary,
            context: context,
            builder: (context) => BlocProvider.value(
              value: profileCubit,
              child: RPadding(
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
                      AppText.changeLanguage.tr(),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const RSizedBox(height: 16),
                    BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) => RadioGroup<Languages>(
                        groupValue: state.selectedLanguage,
                        onChanged: (Languages? value) async {
                          await profileCubit.doIntent(
                            intent: ToggleLanguageIntent(
                              globalCubit: globalCubit,
                              newSelectedLanguage:
                                  value ?? state.selectedLanguage,
                            ),
                          );
                          if (context.mounted) {
                            context.setLocale(
                              globalCubit.isArLanguage
                                  ? const Locale("ar")
                                  : const Locale("en"),
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LanguageItem(
                              languageName: AppText.english,
                              radioItem: Radio<Languages>(
                                value: Languages.english,
                                activeColor: theme.colorScheme.primary,
                                toggleable: true,
                              ),
                            ),
                            const RSizedBox(height: 16),
                            LanguageItem(
                              languageName: AppText.arabic,
                              radioItem: Radio<Languages>(
                                value: Languages.arabic,
                                activeColor: theme.colorScheme.primary,
                                toggleable: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/*
*
*
*  RadioGroup<Languages>(
            onChanged: (value) {
              currentLanguage = value!;
            },
            groupValue: currentLanguage,
            child: Radio<Languages>(
              value: currentLanguage,
              activeColor: theme.colorScheme.primary,
              toggleable: true,
            ),
          ),
*
* */
