import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_intent.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flowery_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowMapButton extends StatelessWidget {
  const ShowMapButton({super.key});

  @override
  Widget build(BuildContext context) {
    final trackOrderCubit = BlocProvider.of<TrackOrderProgressCubit>(context);
    return BlocBuilder<TrackOrderProgressCubit, TrackOrderProgressState>(
      builder: (context, state) => CustomElevatedButton(
        onPressed: state.currentOrderStateIndex >= 2
            ? () {
                trackOrderCubit.doIntent(intent: const ShowMapIntent());
              }
            : null,
        buttonTitle: AppText.showMap,
        height: 50.h,
      ),
    );
  }
}
