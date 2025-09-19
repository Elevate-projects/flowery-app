import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/presentation/cart/views/widget/custom_cart_shimmer.dart';
import 'package:flowery_app/presentation/order_page/view_model/order_page_cubit.dart';
import 'package:flowery_app/presentation/order_page/view_model/order_page_status.dart';
import 'package:flowery_app/presentation/order_page/widget/custom_order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderViewBody extends StatelessWidget {
  const OrderViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<GetUserOrderCubit, GetUserOrderState>(
      builder: (context, state) {
        if (state.orderStatus.isLoading) {
          return const Center(child: CustomCartDetailsShimmer());
        }

        if (state.orderStatus.isFailure) {
          return Center(
            child: Text(
              state.orderStatus.error?.message ?? AppText.error.tr(),
              style: theme.textTheme.bodyMedium,
            ),
          );
        }

        if (state.orderStatus.isSuccess) {
          final orders = state.orderStatus.data?.orders ?? [];
          final activeOrders = orders.where((o) => o.isPaid == false).toList();
          final completedOrders = orders
              .where((o) => o.isPaid == true)
              .toList();

          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  indicatorColor: theme.colorScheme.primary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: theme.colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: AppText.active.tr()),
                    Tab(text: AppText.completed.tr()),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      /// Active Orders
                      ListView.builder(
                        itemCount: activeOrders.length,
                        padding: REdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          final order = activeOrders[index];
                          return Padding(
                            padding: REdgeInsets.only(bottom: 10),
                            child: CustomOrder(order: order),
                          );
                        },
                      ),

                      /// Completed Orders
                      ListView.builder(
                        itemCount: completedOrders.length,
                        padding: REdgeInsets.all(12),
                        itemBuilder: (context, index) {
                          final order = completedOrders[index];
                          return Padding(
                            padding: REdgeInsets.only(bottom: 10),
                            child: CustomOrder(order: order),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
