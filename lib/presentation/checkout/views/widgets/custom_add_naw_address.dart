import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomAddAddressButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAddAddressButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: REdgeInsets.symmetric(horizontal: 13),
      child: SizedBox(
        height: 40.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: theme.colorScheme.shadow),
              borderRadius: BorderRadius.circular(20.r),
            ),
            backgroundColor: theme.colorScheme.secondary,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add),
              const RSizedBox(width: 5),
              Text(AppText.addAddress.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
