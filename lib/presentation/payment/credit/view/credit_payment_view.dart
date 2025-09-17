import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/presentation/payment/credit/view/widgets/credit_checkout_web_view.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_state.dart';
import 'package:flowery_app/presentation/order_page/order_page.dart';

class CreditPaymentView extends StatelessWidget {
  final List<CartItemEntity> cartItems;

  const CreditPaymentView({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreditPaymentViewModel, CreditPaymentState>(
      listener: (context, state) {
        if (state is CreditPaymentRedirect) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreditCheckoutWebView(url: state.url),
            ),
          );
        } else if (state is CreditPaymentSuccess) {
          Loaders.showSuccessMessage(
            message: state.response.message ?? '',
            context: context,
          );

        } else if (state is CreditPaymentFailure) {
          Loaders.showErrorMessage(message: state.message, context: context);
        }
        else if (state is CreditPaymentCompleted) {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => OrderPage(cartItems: cartItems)),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
