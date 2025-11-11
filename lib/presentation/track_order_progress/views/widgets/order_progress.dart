import 'package:flowery_app/presentation/track_order_progress/views/widgets/order_progress_item.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderProgress extends StatelessWidget {
  const OrderProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: BlocBuilder<TrackOrderProgressCubit, TrackOrderProgressState>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: state.orderStates
              .asMap()
              .entries
              .map(
                (orderState) => OrderProgressItem(
                  title: orderState.value,
                  isLastItem: orderState.value == state.orderStates.last,
                  isStateCompleted:
                      state.currentOrderStateIndex >= orderState.key,
                  progressDate: state.orderProgressDates[orderState.key],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
