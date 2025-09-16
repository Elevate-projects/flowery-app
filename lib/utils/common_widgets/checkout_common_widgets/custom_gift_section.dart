import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/checkout_page/view_model/checkout_cubit/checkout_view_model.dart';
import 'package:flowery_app/presentation/checkout_page/view_model/checkout_cubit/gift_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomGiftSection extends StatelessWidget {
  const CustomGiftSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: BlocBuilder<GiftSwitchCubit, GiftSwitchState>(
                  builder: (context, state) {
                    if (state is GiftSwitchInitial) {
                      return Switch.adaptive(
                        value: state.isGift,
                        onChanged: (value) {
                          context.read<GiftSwitchCubit>().toggleGiftSwitch(value);
                        },
                        padding: EdgeInsets.zero,
                        activeThumbColor: theme.colorScheme.secondary,
                        activeTrackColor: theme.colorScheme.primary,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
              const RSizedBox(width: 10),
              Text(
                AppText.itsGift.tr(),
                style: theme.textTheme.headlineSmall,
              ),
            ],
          ),
        ),
        BlocBuilder<GiftSwitchCubit, GiftSwitchState>(
          builder: (context, state) {
            if (state is GiftSwitchInitial && state.isGift) {
              return Column(
                children: [
                   const RSizedBox(height: 5),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextFormField(
                      label: AppText.name.tr(),
                      hintText: AppText.enterName.tr(),
                    ),
                  ),
                  const RSizedBox(height: 10),
                  Padding(
                    padding: REdgeInsets.symmetric(horizontal: 10),
                    child: CustomTextFormField(
                      label: AppText.phoneNumber.tr(),
                      hintText: AppText.enterPhoneNumber.tr(),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
