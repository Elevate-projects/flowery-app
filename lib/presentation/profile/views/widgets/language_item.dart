import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageItem extends StatelessWidget {
  const LanguageItem({
    super.key,
    required this.languageName,
    required this.radioItem,
  });
  final String languageName;
  final Widget radioItem;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: ScreenUtil().screenWidth,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSecondary.withValues(alpha: 0.1),
            blurStyle: BlurStyle.outer,
            blurRadius: 5.r,
          ),
        ],
      ),
      padding: REdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                languageName.tr(),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const RSizedBox(width: 12),
          radioItem,
        ],
      ),
    );
  }
}
