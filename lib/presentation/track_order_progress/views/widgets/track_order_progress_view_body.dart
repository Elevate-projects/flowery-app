import 'dart:developer';

import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/show_map/views/widgets/map_section.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_cubit.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_intent.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/driver_details.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/estimated_arrive.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/order_placed.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/order_progress.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/received_the_order_button.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/show_map_button.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flowery_app/utils/common_widgets/loading_circle.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOrderProgressViewBody extends StatelessWidget {
  const TrackOrderProgressViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final trackOrderCubit = BlocProvider.of<TrackOrderProgressCubit>(context);
    final theme = Theme.of(context);
    return BlocConsumer<TrackOrderProgressCubit, TrackOrderProgressState>(
      listenWhen: (previous, current) =>
          current.currentOrderStatus.isFailure ||
          current.receivedOrderStatus.isFailure ||
          current.receivedOrderStatus.isSuccess,
      listener: (context, state) {
        if (state.currentOrderStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.currentOrderStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.receivedOrderStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.receivedOrderStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.receivedOrderStatus.isSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Loaders.showSuccessMessage(
            message: AppText.receivedOrderMessage,
            context: context,
          );
        }
      },
      builder: (context, state) {
        log(state.currentOrderStateIndex.toString());
        if (state.currentOrderStatus.isSuccess) {
          return state.currentOrderStatus.data == null
              ? const OrderPlaced()
              : state.isShowMap
              ? MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: trackOrderCubit),
                    BlocProvider<ShowMapCubit>(
                      create: (context) => getIt.get<ShowMapCubit>()
                        ..doIntent(
                          ShowMapInitializationIntent(
                            orderData: state.currentOrderStatus.data!,
                          ),
                        ),
                    ),
                  ],
                  child: const MapSection(),
                )
              : SingleChildScrollView(
                  child: RPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const RSizedBox(height: 24),
                        const EstimatedArrive(),
                        Divider(
                          height: 1.0,
                          color: AppColors.white[70]?.withValues(alpha: 0.5),
                        ),
                        const RSizedBox(height: 40),
                        const DriverDetails(),
                        const RSizedBox(height: 40),
                        const OrderProgress(),
                        state.currentOrderStatus.data?.state ==
                                ConstKeys.deliveredToTheUser
                            ? const ReceivedTheOrderButton()
                            : const ShowMapButton(),
                        const RSizedBox(height: 12),
                      ],
                    ),
                  ),
                );
        } else {
          return Center(
            child: LoadingCircle(circleColor: theme.colorScheme.primary),
          );
        }
      },
    );
  }
}
