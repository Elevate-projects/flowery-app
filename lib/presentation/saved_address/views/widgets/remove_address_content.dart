import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_cubit.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_intent.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemoveAddressContent extends StatelessWidget {
  const RemoveAddressContent({super.key, required this.addressId});
  final String addressId;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final savedAddressCubit = BlocProvider.of<SavedAddressCubit>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppText.deleteAddress.tr(),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const RSizedBox(height: 8),
        Text(
          AppText.deleteAddressMessage.tr(),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: theme.colorScheme.onSecondary,
          ),
          textAlign: TextAlign.center,
        ),
        const RSizedBox(height: 24),
        BlocBuilder<SavedAddressCubit, SavedAddressState>(
          buildWhen: (previous, current) =>
              current.removeAddressStatus.isFailure ||
              current.removeAddressStatus.isLoading,
          builder: (context, state) => Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: state.removeAddressStatus.isLoading
                      ? () {}
                      : () {
                          Navigator.of(context).pop();
                        },
                  borderColor: theme.colorScheme.shadow,
                  backgroundColor: theme.colorScheme.secondary,
                  titleStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.shadow,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                  buttonTitle: AppText.cancel.tr(),
                  height: 40.h,
                ),
              ),
              const RSizedBox(width: 16),
              Expanded(
                child: state.removeAddressStatus.isLoading
                    ? LoadingButton(
                        height: 40.h,
                        loadingCircleWidth: 16.r,
                        loadingCircleHeight: 16.r,
                      )
                    : CustomElevatedButton(
                        onPressed: () async {
                          await savedAddressCubit.doIntent(
                            intent: RemoveAddressIntent(addressId: addressId),
                          );
                        },
                        buttonTitle: AppText.delete,
                        titleStyle: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.1,
                        ),
                        height: 40.h,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
