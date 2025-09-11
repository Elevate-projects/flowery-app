import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationSelector extends StatelessWidget {
  const LocationSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.location_on_outlined,
          size: 18.sp,
          color: Colors.black87,
        ),
        SizedBox(width: 4.w),

        // Texts
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Deliver to ",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.black,
                ),
              ),
              TextSpan(
                text: "2XVP+XC - Sheikh Zayed",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 4.w),

        // Dropdown arrow
        Icon(
          Icons.keyboard_arrow_down,
          size: 18.sp,
          color: Colors.pink,
        ),
      ],
    );
  }
}