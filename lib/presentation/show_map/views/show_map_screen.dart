import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/presentation/show_map/views/widgets/map_section.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowMapScreen extends StatelessWidget {
  const ShowMapScreen({super.key, required this.orderData});

  final OrderEntity orderData;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShowMapCubit>(
          create: (context) => getIt.get<ShowMapCubit>(),
        ),
        BlocProvider<TrackOrderProgressCubit>(
          create: (context) => getIt.get<TrackOrderProgressCubit>(),
        ),
      ],
      child: Scaffold(body: MapSection(orderData: orderData)),
    );
  }
}
