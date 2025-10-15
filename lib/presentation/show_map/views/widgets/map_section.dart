import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/presentation/show_map/views/widgets/driver_information.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_cubit.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_intent.dart';
import 'package:flowery_app/presentation/show_map/views_model/show_map_state.dart';
import 'package:flowery_app/presentation/track_order_progress/views/widgets/estimated_arrive.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key, required this.orderData});

  final OrderEntity orderData;

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  @override
  void initState() {
    super.initState();
    final LatLng userLocation = LatLng(
      double.parse(widget.orderData.shippingAddress!.lat.toString()),
      double.parse(widget.orderData.shippingAddress!.long.toString()),
    );
    LatLng storeLocation = const LatLng(0, 0);
    final String latLongString = widget.orderData.store?.latLong ?? '';
    final int commaIndex = latLongString.indexOf(',');

    // Only parse if the string is valid and contains a comma
    if (commaIndex != -1) {
      final String storeLat = latLongString.substring(0, commaIndex).trim();
      final String storeLng = latLongString.substring(commaIndex + 1).trim();
      storeLocation = LatLng(double.parse(storeLat), double.parse(storeLng));
    }
    context.read<ShowMapCubit>().doIntent(
      ShowMapInitializationIntent(
        userLocation: userLocation,
        storeLocation: storeLocation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ShowMapCubit>();

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
                  MarkerLayer(
                    markers: [
                      if (user != null)
                        Marker(
                          point: user,
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
                          alignment: Alignment.center,
                          child: AnimatedScale(
                            scale: 1.0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut,
                            child: SvgPicture.asset(AppIcons.mark),
                          ),
                        ),
                    ],
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
                            onPressed: () {},
                            buttonTitle: 'Order Details',
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
