import 'dart:math' as math;

import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/presentation/show_map/views/widgets/driver_information.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_cubit.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_state.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/estimated_arrive.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_intent.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class MapSection extends StatelessWidget {
  const MapSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShowMapCubit>();
    final trackOrderCubit = BlocProvider.of<TrackOrderProgressCubit>(context);
    return BlocBuilder<ShowMapCubit, ShowMapState>(
      builder: (context, state) {
        final theme = Theme.of(context);
        final store = state.storeLocation;
        final user = state.userLocation;
        return Stack(
          children: [
            SizedBox.expand(
              child: FlutterMap(
                mapController: cubit.mapController,
                options: MapOptions(
                  initialCenter: store ?? user ?? const LatLng(0, 0),
                  initialZoom: 15.sp,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                  ),
                  if (state.polylinePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: state.polylinePoints,
                          color: theme.primaryColor,
                          strokeWidth: 5.w,
                        ),
                      ],
                    ),
                  BlocBuilder<TrackOrderProgressCubit, TrackOrderProgressState>(
                    builder: (context, state) {
                      return MarkerLayer(
                        markers: [
                          if (user != null)
                            Marker(
                              point: user,
                              width: 50.w,
                              height: 50.h,
                              alignment: Alignment.center,
                              child: AnimatedScale(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                scale: 1.0,
                                child: SvgPicture.asset(AppIcons.mark),
                              ),
                            ),
                          if (store != null)
                            Marker(
                              point: store,
                              width: 50.w,
                              height: 50.h,
                              alignment: Alignment.center,
                              child: AnimatedScale(
                                scale: 1.0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                child: SvgPicture.asset(AppIcons.mark),
                              ),
                            ),
                          if (state.currentOrderStatus.data != null)
                            Marker(
                              point: LatLng(
                                double.parse(
                                  state.currentOrderStatus.data!.driverLatitude
                                      .toString(),
                                ),
                                double.parse(
                                  state.currentOrderStatus.data!.driverLongitude
                                      .toString(),
                                ),
                              ),
                              width: 50.w,
                              height: 50.h,
                              alignment: Alignment.center,
                              child: AnimatedScale(
                                scale: 1.0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                child: Transform.rotate(
                                  angle: state.bearing * (math.pi / 180),
                                  child: SvgPicture.asset(AppIcons.motorCycle),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: 0.38.sp,
              minChildSize: 0.04.sp,
              initialChildSize: 0.38.sp,
              snap: true,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 6.r,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: REdgeInsets.all(16),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 70.w,
                              height: 4.h,
                              margin: REdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                          ),
                          const EstimatedArrive(),
                          Divider(
                            height: 1.0,
                            color: AppColors.white[70]?.withValues(alpha: 0.5),
                          ),
                          const RSizedBox(height: 40),
                          const DriverInformation(),
                          const RSizedBox(height: 40),
                          CustomElevatedButton(
                            onPressed: () {
                              trackOrderCubit.doIntent(
                                intent: const ShowMapIntent(),
                              );
                            },
                            buttonTitle: AppText.orderDetails,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
