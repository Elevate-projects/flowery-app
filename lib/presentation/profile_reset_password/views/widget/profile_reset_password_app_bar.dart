import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileResetPasswordAppBar extends StatelessWidget {
  const ProfileResetPasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.black,
                  size: 24.r,
                ),
              ),
              Flexible(
                child: Text(
                  AppText.resetPassword.tr(),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontFamily: "Roboto",
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ]
    );
  }
}