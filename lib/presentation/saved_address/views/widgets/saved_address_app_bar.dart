import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SavedAddressAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SavedAddressAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: AppText.savedAddress.tr(),
      automaticallyImplyLeading: true,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back_ios),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
