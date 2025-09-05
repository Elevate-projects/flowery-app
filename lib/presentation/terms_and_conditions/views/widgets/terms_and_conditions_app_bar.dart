import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const TermsAndConditionsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      automaticallyImplyLeading: true,
      title: AppText.termsConditions.tr(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
