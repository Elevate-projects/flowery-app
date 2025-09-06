import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_images.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserProfileDetails extends StatelessWidget {
  const UserProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current.profileStatus.isLoading || current.profileStatus.isSuccess,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40.5.r,
            backgroundImage: const AssetImage(AppImages.defaultProfile),
          ),
          const RSizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: state.profileStatus.isLoading
                    ? ShimmerEffect(width: 140.w, height: 14.h)
                    : Text(
                        "${FloweryMethodHelper.userData?.firstName} ${FloweryMethodHelper.userData?.lastName}",
                        style: theme.textTheme.headlineSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              const RSizedBox(width: 4),
              GestureDetector(
                onTap:
                    (!state.profileStatus.isLoading &&
                        FloweryMethodHelper.userData != null)
                    ? () {
                        // Navigate to edit profile
                        Navigator.of(context).pushNamed(RouteNames.resetPassword);
                      }
                    : () {},
                child: SvgPicture.asset(AppIcons.edit, fit: BoxFit.contain),
              ),
            ],
          ),
          const RSizedBox(height: 4),
          state.profileStatus.isLoading
              ? ShimmerEffect(width: 240.w, height: 14.h)
              : Text(
                  FloweryMethodHelper.userData?.email ?? "",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.shadow,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
        ],
      ),
    );
  }
}
