import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/cart/views/widget/cart_app_bar.dart';
import 'package:flowery_app/presentation/cart/views/widget/cart_view_body.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_cubit.dart';
import 'package:flowery_app/presentation/cart/views_model/cart_cubit/cart_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>(
      create: (context) => getIt.get<CartCubit>()..doIntent(LoadCartIntent()),
      child: const Scaffold(appBar: CartAppBar(), body: CartViewBody()),
    );
  }
}
