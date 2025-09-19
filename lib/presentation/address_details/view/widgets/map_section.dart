import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_cubit.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSection extends StatefulWidget {
  const MapSection({super.key});

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAddressCubit, AddAddressState>(
      builder: (context, state) {
        return Stack(
          children: [
            SizedBox(
              height: 150.h,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: state.selectedLocation,
                  zoom: 14.sp,
                ),
                onTap: (LatLng position) {
                  context.read<AddAddressCubit>().selectLocation(position);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,

                markers: {
                  Marker(
                    markerId: const MarkerId("selected"),
                    position: state.selectedLocation,
                  ),
                },
              ),
            ),
            Positioned(
              bottom: 1.r,
              left: 1.r,
              child: Container(
                padding: REdgeInsets.all(12),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  state.address.isEmpty
                      ? AppText.tapOnMapToGetAddress.tr()
                      : state.address,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
