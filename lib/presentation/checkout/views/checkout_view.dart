import 'package:flowery_app/presentation/checkout/views/widgets/checkout_view_body.dart';
import 'package:flowery_app/presentation/checkout/views_model/adress_cubit/adress_cubit.dart';
import 'package:flowery_app/presentation/checkout/views_model/checkout_cubit/checkout_view_model.dart';
import 'package:flowery_app/presentation/checkout/views_model/payment_cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutView extends StatelessWidget {
  final int subTotal;
  const CheckoutView({super.key, required this.subTotal});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GiftSwitchCubit()),
        BlocProvider(create: (_) => PaymentCubit()),
        BlocProvider(create: (_) => AddressCubit()),
      ],
      child: CheckoutViewBody(subTotal: subTotal),
    );
  }
}
