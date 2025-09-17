import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/enum/gender.dart';
import 'package:flowery_app/presentation/auth/register/view_model/register_state.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileRegisterGenderRadioButton extends StatelessWidget {
  const EditProfileRegisterGenderRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EditProfileCubit>(context);
    final theme = Theme.of(context);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (previous, current) => current is GenderChangedState,
      builder: (context, state) {
        return Expanded(
          flex: 3,
          child: Row(
            children: [
              RadioMenuButton<Gender>(
                value: Gender.female,
                groupValue: controller.selectedGender,
                onChanged: null,
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: WidgetStateProperty.all(
                    theme.colorScheme.onSurface,
                  ),
                  overlayColor: WidgetStateProperty.all(
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: RSizedBox(
                  width: 53,
                  child: FittedBox( 
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppText.genderFemaleDisplay.tr(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              RadioMenuButton<Gender>(
                value: Gender.male,
                groupValue: controller.selectedGender,
                onChanged: null,
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: WidgetStateProperty.all(
                    theme.colorScheme.onSurface,
                  ),
                  overlayColor: WidgetStateProperty.all(
                    theme.colorScheme.primary.withValues(alpha: 0.1),
                  ),
                ),
                child: RSizedBox(
                  width: 53,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      AppText.genderMaleDisplay.tr(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
