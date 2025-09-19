import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_colors.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/profile/views/widgets/language_section.dart';
import 'package:flowery_app/presentation/profile/views/widgets/logout_section.dart';
import 'package:flowery_app/presentation/profile/views/widgets/notification_switch.dart';
import 'package:flowery_app/presentation/profile/views/widgets/profile_navigation_item.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileNavigationSection extends StatelessWidget {
  const ProfileNavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Visibility(
          visible: FloweryMethodHelper.currentUserToken != null,
          child: Column(
            children: [
              ProfileNavigationItem(
                title: AppText.myOrders,
                prefixIconPath: AppIcons.orders,
                onTap: () {},
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) => ProfileNavigationItem(
                  title: AppText.savedAddress,
                  prefixIconPath: AppIcons.location,
                  onTap: state.profileStatus.isLoading
                      ? () {}
                      : () {
                          Navigator.of(context).pushNamed(
                            RouteNames.savedAddress,
                            arguments: FloweryMethodHelper.userData?.addresses,
                          );
                        },
                ),
              ),
              Divider(color: AppColors.white[70], height: 32.h),
              const NotificationSwitch(),
              Divider(color: AppColors.white[70], height: 32.h),
            ],
          ),
        ),
        const LanguageSection(),
        ProfileNavigationItem(
          isIconWithTitle: false,
          titleWidget: Text(
            AppText.aboutUs.tr(),
            style: theme.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(RouteNames.aboutUs);
          },
        ),
        ProfileNavigationItem(
          isIconWithTitle: false,
          titleWidget: Text(
            AppText.termsConditions.tr(),
            style: theme.textTheme.bodyMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(RouteNames.termsAndConditions);
          },
        ),
        Divider(color: AppColors.white[70], height: 32.h),
        const LogoutSection(),
      ],
    );
  }
}
