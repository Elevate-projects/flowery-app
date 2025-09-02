import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class RegisterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const RegisterAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(centerTitle: false, title: AppText.signup,automaticallyImplyLeading: true,);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
