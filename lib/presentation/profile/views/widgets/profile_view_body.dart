import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/presentation/profile/views/widgets/profile_app_bar.dart';
import 'package:flowery_app/presentation/profile/views/widgets/profile_navigation_section.dart';
import 'package:flowery_app/presentation/profile/views/widgets/user_profile_details.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_cubit.dart';
import 'package:flowery_app/presentation/profile/views_model/profile_state.dart';
import 'package:flowery_app/presentation/track_order/view/track_order_page.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          current.profileStatus.isFailure ||
          current.logoutStatus.isFailure ||
          current.logoutStatus.isSuccess,
      listener: (context, state) {
        if (state.profileStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.profileStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.logoutStatus.isFailure) {
          Navigator.of(context).pop();
          Loaders.showErrorMessage(
            message: state.logoutStatus.error?.message ?? "",
            context: context,
          );
        } else if (state.logoutStatus.isSuccess) {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(RouteNames.login, (route) => false);
        }
      },
      child: SingleChildScrollView(
        child: RPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const RSizedBox(height: 12),
              const ProfileAppBar(),
              Visibility(
                visible: FloweryMethodHelper.currentUserToken != null,
                child: const Column(
                  children: [RSizedBox(height: 27), UserProfileDetails()],
                ),
              ),
              const RSizedBox(height: 21),
              const ProfileNavigationSection(),
              const RSizedBox(height: 54),
              Text(
                AppText.version.tr(),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.shadow,
                ),
              ),
              const RSizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const TrackOrderPage(),));
                },
                child: null,

              )
            ],
          ),
        ),
      ),
    );
  }
}
