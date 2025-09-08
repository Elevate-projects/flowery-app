import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_cubit.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_intent.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterGenderRadioButton extends StatelessWidget {
  const RegisterGenderRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<RegisterCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => current is GenderChangedState,
      builder: (context, state) {
        final selectedGender = state is GenderChangedState
            ? state.selectedGender
            : null;

        return Row(
          children: [
            Flexible(
              child: RadioMenuButton<Gender>(
                value: Gender.female,
                groupValue: selectedGender,
                onChanged: (value) {
                  if (value != null) {
                    controller.doIntent(
                      intent: ChangeGenderIntent(gender: value),
                    );
                  }
                },
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: WidgetStateProperty.all(
                    theme.colorScheme.onSurface,
                  ),
                  overlayColor: WidgetStateProperty.all(
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  AppText.genderFemaleDisplay.tr(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Flexible(
              child: RadioMenuButton<Gender>(
                value: Gender.male,
                groupValue: selectedGender,
                onChanged: (value) {
                  if (value != null) {
                    controller.doIntent(
                      intent: ChangeGenderIntent(gender: value),
                    );
                  }
                },
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: WidgetStateProperty.all(
                    theme.colorScheme.onSurface,
                  ),
                  overlayColor: WidgetStateProperty.all(
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  AppText.genderMaleDisplay.tr(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
