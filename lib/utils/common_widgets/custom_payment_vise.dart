import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_radio_button/group_radio_button.dart';

class CustomPaymentVise extends StatelessWidget {
  const CustomPaymentVise({super.key});

  @override
  Widget build(BuildContext context) {
    final String method = "Credit Card ";
    final theme = Theme.of(context);
    return Container(
      width: 343.w,
      height: 53.h,
      padding: REdgeInsets.all(8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: theme.colorScheme.shadow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioButton(
            description: AppText.paymentCard.tr(),
            value: AppText.paymentCard.tr(),
            groupValue: method,
            onChanged: (val) {
            },
            textPosition: RadioButtonTextPosition.right,
          ),
        ],
      ),
    );
  }
}

