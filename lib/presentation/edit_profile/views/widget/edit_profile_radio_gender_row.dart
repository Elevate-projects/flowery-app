import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/auth/register/views/widgets/register_gender_radio_button.dart';
import 'package:flowery_app/presentation/edit_profile/views/widget/edit_profile_gender_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileRadioGenderRow extends StatelessWidget {
  const EditProfileRadioGenderRow({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            AppText.genderLabel,
            style: theme.textTheme.headlineSmall,
          ),
          const RSizedBox(width: 40),
          const Expanded(
            child: EditProfileRegisterGenderRadioButton(),
          ),
        ],
      );
  }
}