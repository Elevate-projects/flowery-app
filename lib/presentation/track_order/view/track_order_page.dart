import 'package:flowery_app/presentation/track_order/view/map_view.dart';
import 'package:flowery_app/presentation/track_order/widget/details_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MapToView(
                destinationLat: 30.0444,
                destinationLon: 31.2357,
              ),
               RSizedBox(height: 15),
              DetailsSection(),
              RSizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
