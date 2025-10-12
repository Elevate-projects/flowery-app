import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/track_order_progress_app_bar.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/track_order_progress_view_body.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderProgressView extends StatelessWidget {
  const TrackOrderProgressView({super.key, required this.orderId});
  final String orderId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrackOrderProgressCubit>(
      create: (context) =>
          getIt.get<TrackOrderProgressCubit>()
            ..doIntent(intent: FetchTrackedOrderDataIntent(orderId: orderId)),
      child: const Scaffold(
        appBar: TrackOrderProgressAppBar(),
        body: TrackOrderProgressViewBody(),
      ),
    );
  }
}
