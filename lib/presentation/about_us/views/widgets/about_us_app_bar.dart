import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AboutUsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AboutUsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomAppBar(
      automaticallyImplyLeading: true,
      title: AppText.aboutUs,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
