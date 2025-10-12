import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_intent.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/loading_button.dart';
import 'package:flowery_app/utils/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceivedTheOrderButton extends StatelessWidget {
  const ReceivedTheOrderButton({super.key});

  @override
  Widget build(BuildContext context) {
    final trackOrderCubit = BlocProvider.of<TrackOrderProgressCubit>(context);
    final theme = Theme.of(context);
    return CustomElevatedButton(
      onPressed: () async {
        await Dialogs.customDialog(
          isBarrierDismissible: false,
          context: context,
          content: BlocProvider<TrackOrderProgressCubit>.value(
            value: trackOrderCubit,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    AppText.orderReceived.tr(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const RSizedBox(height: 8),
                Text(
                  AppText.receivedTheOrderDialog.tr(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const RSizedBox(height: 24),
                BlocBuilder<TrackOrderProgressCubit, TrackOrderProgressState>(
                  buildWhen: (previous, current) =>
                      current.receivedOrderStatus.isFailure ||
                      current.receivedOrderStatus.isLoading,
                  builder: (context, state) => Row(
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          onPressed: state.receivedOrderStatus.isLoading
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
                          buttonTitle: AppText.back.tr(),
                          height: 40.h,
                        ),
                      ),
                      const RSizedBox(width: 16),
                      Expanded(
                        child: state.receivedOrderStatus.isLoading
                            ? LoadingButton(height: 40.h)
                            : CustomElevatedButton(
                                onPressed: () async {
                                  await trackOrderCubit.doIntent(
                                    intent: const OrderReceivedIntent(),
                                  );
                                },
                                buttonTitle: AppText.received,
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
            ),
          ),
        );
      },
      buttonTitle: AppText.receivedTheOrder,
      height: 50.h,
    );
  }
}
