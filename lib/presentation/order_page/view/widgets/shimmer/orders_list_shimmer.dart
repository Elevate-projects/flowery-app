import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersListShimmer extends StatelessWidget {
  const OrdersListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 12,
      padding: REdgeInsets.symmetric(horizontal: 28, vertical: 24),
      itemBuilder: (context, index) {
        return Padding(
          padding: REdgeInsets.only(bottom: 10),
          child: ShimmerEffect(
            width: ScreenUtil().screenWidth,
            height: 125.h,
            radius: 8.r,
          ),
        );
      },
    );
  }
}
