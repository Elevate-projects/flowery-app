import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/global_cubit/global_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EstimatedArrive extends StatelessWidget {
  const EstimatedArrive({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isArabic = BlocProvider.of<GlobalCubit>(context).isArLanguage;
    return RPadding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.estimatedArrival,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.shadow,
            ),
          ),
          const RSizedBox(height: 8),
          BlocBuilder<TrackOrderProgressCubit, TrackOrderProgressState>(
            builder: (context, state) => Text(
              FloweryMethodHelper.estimatedArrivalDateFormatter(
                state.currentOrderStatus.data?.estimatedArrival,
                isArabic,
              ),
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
          const RSizedBox(height: 16),
        ],
      ),
    );
  }
}
