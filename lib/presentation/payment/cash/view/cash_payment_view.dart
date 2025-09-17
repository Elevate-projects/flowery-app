
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
  import 'package:flowery_app/presentation/payment/cash/view_model/cash_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/cash/view_model/cash_payment_state.dart';
 import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashPaymentView extends StatelessWidget {
  final List<CartItemEntity> cartItems;

  const CashPaymentView({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CashPaymentViewModel, CashPaymentState>(
      listener: (context, state) {
        if (state is CashPaymentSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.floweryBottomNavigation,
                (route) => route.isFirst,
          );
          Loaders.showSuccessMessage(
            message: state.response.message ?? "",
            context: context,

          );


          // );
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (_) => OrderPage(cartItems: cartItems)),
          // );
        } else if (state is CashPaymentFailure) {
          Loaders.showErrorMessage(message: state.message, context: context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
