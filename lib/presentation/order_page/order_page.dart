import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/utils/common_widgets/custom_back_arrow.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/custom_order.dart';
import 'package:flutter/material.dart';
class OrderPage extends StatelessWidget {
  final List<CartItemEntity> cartItems;
  const OrderPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          actionsPadding: EdgeInsets.zero,
          leading: const CustomBackArrow(),
          title: Text(AppText.orderPage.tr()),
        ),
        body: Column(
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
                    padding: const EdgeInsets.all(12),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomOrder(
                          cartitem: cartItems[index],
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CustomOrder(
                          cartitem: cartItems[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
