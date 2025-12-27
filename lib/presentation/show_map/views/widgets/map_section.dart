import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_animations.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/presentation/show_map/views/widgets/driver_information.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_cubit.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_intent.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_state.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/estimated_arrive.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_intent.dart'
    as track_intent;
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flowery_app/utils/common_widgets/location_indicator.dart';
import 'package:flowery_app/utils/loaders/animation_loader_widget.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
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
    return BlocConsumer<ShowMapCubit, ShowMapState>(
      listenWhen: (previous, current) => current.mapStatus.isFailure,
      listener: (context, state) {
        if (state.mapStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.mapStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        final driver = state.driverLocation;
        final user = state.userLocation;
        return Stack(
          children: [
            state.mapStatus.isLoading
                ? const AnimationLoaderWidget(
                    text: "",
                    animation: AppAnimations.loadingAnimationBlue,
                  )
                : SizedBox.expand(
                    child: FlutterMap(
                      mapController: cubit.mapController,
                      options: MapOptions(
                        initialCenter: driver ?? user ?? const LatLng(0, 0),
                        initialZoom: 13,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: ConstKeys.mapUrlTemplate,
                          userAgentPackageName: ConstKeys.appPackageName,
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
                        BlocConsumer<
                          TrackOrderProgressCubit,
                          TrackOrderProgressState
                        >(
                          listenWhen: (previous, current) =>
                              current.currentOrderStatus.data?.driverLatitude !=
                                  previous
                                      .currentOrderStatus
                                      .data
                                      ?.driverLatitude ||
                              current
                                      .currentOrderStatus
                                      .data
                                      ?.driverLongitude !=
                                  previous
                                      .currentOrderStatus
                                      .data
                                      ?.driverLongitude,
                          listener: (context, state) async {
                            if (state.currentOrderStatus.data != null) {
                              final newDriverLocation = LatLng(
                                double.parse(
                                  state.currentOrderStatus.data!.driverLatitude
                                      .toString(),
                                ),
                                double.parse(
                                  state.currentOrderStatus.data!.driverLongitude
                                      .toString(),
                                ),
                              );
                              await cubit.doIntent(
                                UpdateRouteIntent(
                                  driverLocation: newDriverLocation,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            return MarkerLayer(
                              markers: [
                                if (user != null)
                                  Marker(
                                    point: user,
                                    width: 150.w,
                                    height: 90.h,
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: LocationIndicator(
                                        title: AppText.apartment.tr(),
                                        isNetworkImage: false,
                                        imagePath: AppIcons.userLocation,
                                      ),
                                    ),
                                  ),
                                if (state.currentOrderStatus.data != null)
                                  Marker(
                                    point: LatLng(
                                      double.parse(
                                        state
                                            .currentOrderStatus
                                            .data!
                                            .driverLatitude
                                            .toString(),
                                      ),
                                      double.parse(
                                        state
                                            .currentOrderStatus
                                            .data!
                                            .driverLongitude
                                            .toString(),
                                      ),
                                    ),
                                    width: 50.w,
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    child: AnimatedScale(
                                      scale: 1.0,
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      curve: Curves.easeOut,
                                      child: Transform.rotate(
                                        angle: state.bearing * (math.pi / 180),
                                        child: SvgPicture.asset(
                                          AppIcons.motorCycle,
                                        ),
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
              maxChildSize: 0.34.sp,
              minChildSize: 0.04.sp,
              initialChildSize: 0.04.sp,
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
                                intent: const track_intent.ShowMapIntent(),
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
