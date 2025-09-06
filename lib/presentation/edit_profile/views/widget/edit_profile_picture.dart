import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EditProfilePicture extends StatelessWidget {
  const EditProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 40.5.r,
              backgroundImage: const AssetImage(AppImages.defaultProfile),
            ),
             PositionedDirectional(
              bottom: 5,
              end: -6,
              child: Container(
                padding: EdgeInsets.all(5.r),
                width: 24.r,
                height: 24.r,
                decoration: const BoxDecoration(
                  color: AppColors.lightPink,
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: SvgPicture.asset(
                  AppIcons.camera,
                  width: 16.r,
                  height: 16.r,
                  colorFilter: const ColorFilter.mode(AppColors.gray, BlendMode.srcIn),
                ),
              ),),
          ],
        ),
      ],
    );
  }
}