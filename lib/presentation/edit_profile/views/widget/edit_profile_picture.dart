import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_images.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_cubit.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_intents.dart';
import 'package:flowery_app/presentation/edit_profile/view_model/edit_profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EditProfilePicture extends StatelessWidget {
  const EditProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BlocProvider.of<EditProfileCubit>(context);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => controller.doIntent(intent: UploadPhotoIntent()),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 40.5.r,
                    backgroundImage: CachedNetworkImageProvider (FloweryMethodHelper.userData?.photo ?? ""),
                    child: state.uploadPhotoState.isLoading
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          )
                        : null,
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
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: SvgPicture.asset(
                        AppIcons.camera,
                        width: 16.r,
                        height: 16.r,
                        colorFilter: const ColorFilter.mode(
                          AppColors.gray,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
