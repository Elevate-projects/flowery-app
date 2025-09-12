import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/presentation/checkout_page/view/checkout_view.dart';
import 'package:flowery_app/presentation/checkout_page/view_model/adress_cubit/adress_cubit.dart';
import 'package:flowery_app/presentation/checkout_page/view_model/checkout_cubit/checkout_view_model.dart';
import 'package:flowery_app/presentation/checkout_page/view_model/payment_cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  final int subTotal;
  final List<CartItemEntity> cartItem;
  const CheckoutPage({super.key, required this.subTotal, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GiftSwitchCubit()),
        BlocProvider(create: (_) => PaymentCubit()),
        BlocProvider(create: (_) => AddressCubit()),
      ],
      child: CheckoutView(
        subTotal: subTotal,
        cartItems: cartItem,
      ),
    );
  }
}

