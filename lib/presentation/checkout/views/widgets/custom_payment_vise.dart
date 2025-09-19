import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/payment/enum/payment_method.dart';
import 'package:flowery_app/presentation/checkout/views_model/payment_cubit/payment_cubit.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_radio_button/group_radio_button.dart';

class CustomPaymentVise extends StatelessWidget {
  const CustomPaymentVise({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PaymentCubit,PaymentMethod?>(
      builder: (context, method) {
        return Container(
          width: 343.w,
          height: 53.h,
          padding: REdgeInsets.all(8.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: theme.colorScheme.shadow),
          ),
          child: RadioButton(
            description: AppText.paymentCard.tr(),
            value:  PaymentMethod.credit,
            groupValue: method,
            onChanged: (val) {
              context.read<PaymentCubit>().selectMethod(PaymentMethod.credit);

            },
            textPosition: RadioButtonTextPosition.right,
          ),
        );
      },
    );
  }
}


