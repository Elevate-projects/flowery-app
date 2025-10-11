import 'package:flowery_app/presentation/track_order/view_model/map_cubit.dart';
import 'package:flowery_app/presentation/track_order/widget/map_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapToView extends StatelessWidget {
  final double destinationLat;
  final double destinationLon;
  const MapToView({super.key, required this.destinationLat, required this.destinationLon});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MapCubit()
            ..initializeLocation(
            destinationLat,
            destinationLon,
            ),
            child: const MapViewBody(),
    );
  }
}
