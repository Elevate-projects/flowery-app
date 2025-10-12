import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/track_order/view_model/map_cubit.dart';
import 'package:flowery_app/presentation/track_order/view_model/map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
class MapViewBody extends StatelessWidget {
  const MapViewBody({super.key,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
        height: 500,
        width: double.infinity,
        child: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            return FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(
                  30.0444,
                  31.2357,
                ),
                initialZoom: 10,
                maxZoom: 18,
                minZoom: 3,
              ),
              mapController: context.read<MapCubit>().controller,
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  userAgentPackageName: 'com.example.flowery_app',
                ),
                if (state.currentLocation != null &&
                    state.destination != null &&
                    state.routePoints.isNotEmpty)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: state.routePoints,
                        strokeWidth: 4,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                if (context.read<MapCubit>().motorcyclePosition != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: context.read<MapCubit>().motorcyclePosition!,
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppIcons.motorcycle,
                          width: 35.w,
                          height: 35.h,
                        ),
                      ),
                    ],
                  ),
                if (state.destination != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: state.destination!,
                        width: 130.w,
                        height: 80.h,
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: REdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(20.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.shadow,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    AppIcons.apartment,
                                    height: 16.h,
                                    width: 16.w,
                                  ),
                                  const RSizedBox(width: 6),
                                  Text(
                                    AppText.apartment.tr(),
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.location_on_outlined,
                              color: theme.colorScheme.primary,
                              size: 35,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                CurrentLocationLayer(
                  style: LocationMarkerStyle(
                    marker: Column(
                      children: [
                        Container(
                          height: 24,
                          padding: REdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.shadow,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                AppIcons.flower,
                                height: 16,
                                width: 16,
                              ),
                              const RSizedBox(width: 6),
                              Text(
                                AppText.flowery.tr(),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          color: theme.colorScheme.primary,
                          size: 35,
                        ),
                      ],
                    ),
                    markerSize: const Size(120, 60),
                    markerDirection: MarkerDirection.heading,
                  ),
                ),
              ],
            );
          },
        ),
    );
  }
}