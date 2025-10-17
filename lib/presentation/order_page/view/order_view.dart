import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/order_page/view/widgets/order_view_body.dart';
import 'package:flowery_app/presentation/order_page/view_model/order_page_cubit.dart';
import 'package:flowery_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        actionsPadding: EdgeInsets.zero,
        leading: const CustomBackArrow(),
        title: Text(AppText.orderPage.tr()),
      ),
      body: BlocProvider<GetUserOrderCubit>(
        create: (context) => getIt<GetUserOrderCubit>()..fetchUserOrders(),
        child: const OrderViewBody(),
      ),
    );
  }
}
