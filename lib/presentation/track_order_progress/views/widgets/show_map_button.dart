import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowMapButton extends StatelessWidget {
  const ShowMapButton({super.key, required this.orderData});

  final OrderEntity orderData;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(
          context,
          RouteNames.showMap,
          arguments: orderData,
        );
      },
      buttonTitle: AppText.showMap,
      height: 50.h,
    );
  }
}
