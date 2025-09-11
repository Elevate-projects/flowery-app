import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';

class AddressDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AddressDetailsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(AppText.addressWord.tr()));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
