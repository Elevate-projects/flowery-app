import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_gender_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileRadioGenderRow extends StatelessWidget {
  const EditProfileRadioGenderRow({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(AppText.genderLabel.tr(), style: theme.textTheme.headlineSmall))),
        const RSizedBox(width: 40),
        const EditProfileRegisterGenderRadioButton(),
      ],
    );
  }
}
