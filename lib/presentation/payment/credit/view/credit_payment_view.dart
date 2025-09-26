import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/presentation/payment/credit/view/widgets/credit_payment_view_body.dart';
import 'package:flutter/material.dart';

class CreditPaymentView extends StatelessWidget {
  final List<CartItemEntity> cartItems;

  const CreditPaymentView({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return CreditPaymentViewBody(cartItems: cartItems);
  }
}
