import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_icons.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_intent.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flowery_app/utils/common_widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DriverInformation extends StatelessWidget {
  const DriverInformation({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trackOrderProgressCubit = BlocProvider.of<TrackOrderProgressCubit>(
      context,
    );
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.deliveryBoy,
                fit: BoxFit.contain,
                height: 36.h,
              ),
              const RSizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child:
                      BlocBuilder<
                          TrackOrderProgressCubit,
                          TrackOrderProgressState
                      >(
                        builder: (context, state) => Text(
                          state.currentOrderStatus.data?.driverName ?? "",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                    const RSizedBox(height: 8),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        AppText.deliveryHero.tr(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.shadow,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const RSizedBox(width: 20),
              Padding(
                padding: REdgeInsetsDirectional.only(end: 4),
                child: Row(
                  children: [
                    BlocBuilder<
                        TrackOrderProgressCubit,
                        TrackOrderProgressState
                    >(
                      builder: (context, state) =>
                      (state.openPhoneStatus.isLoading &&
                          state
                              .isOpeningPhone) // state.selectedPhoneNumber == state.
                          ? LoadingCircle(
                        circleColor: theme.colorScheme.primary,
                        height: 14.r,
                        width: 14.r,
                      )
                          : InkWell(
                        borderRadius: BorderRadius.circular(100.r),
                        onTap: () async {
                          await trackOrderProgressCubit.doIntent(
                            intent: const OpenPhoneIntent(),
                          );
                        },
                        highlightColor: theme.colorScheme.onPrimary,
                        splashColor: theme.colorScheme.onPrimary,
                        child: RPadding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppIcons.phone,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const RSizedBox(width: 8),
                    BlocBuilder<
                        TrackOrderProgressCubit,
                        TrackOrderProgressState
                    >(
                      builder: (context, state) =>
                      (state.openWhatsappStatus.isLoading &&
                          state
                              .isOpeningWhatsapp) //state.selectedPhoneNumber == phone
                          ? LoadingCircle(
                        circleColor: theme.colorScheme.primary,
                        height: 14.r,
                        width: 14.r,
                      )
                          : InkWell(
                        borderRadius: BorderRadius.circular(100.r),
                        highlightColor: theme.colorScheme.onPrimary,
                        splashColor: theme.colorScheme.onPrimary,
                        onTap: () async {
                          await trackOrderProgressCubit.doIntent(
                            intent: const OpenWhatsAppIntent(),
                          );
                        },
                        child: RPadding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppIcons.whatsapp,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
