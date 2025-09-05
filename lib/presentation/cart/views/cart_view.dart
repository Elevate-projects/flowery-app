import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/cart_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_state.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/quantity_cubit/quantity_state.dart';
import 'package:flowery_app/presentation/cart/widget/cart_page.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>(
          create: (context) => getIt.get<CartCubit>()
            ..doIntent(
              LoadCartIntent(
                FloweryMethodHelper.currentUserToken ?? "",
              ),
            ),
        ),
        BlocProvider<QuantityCubit>(
          create: (context) => getIt.get<QuantityCubit>(),
        ),
        BlocProvider<DeleteCartCubit>(
          create: (context) => getIt.get<DeleteCartCubit>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<QuantityCubit, QuantityState>(
            listener: (context, state) {
              if (state.quantityStatus.isSuccess) {
                context.read<CartCubit>().doIntent(
                  LoadCartIntent(FloweryMethodHelper.currentUserToken ?? ""),
                );
              }
            },
          ),
          BlocListener<DeleteCartCubit, DeleteCartState>(
            listener: (context, state) {
              if (state.deleteStatus.isSuccess) {
                context.read<CartCubit>().doIntent(
                  LoadCartIntent(FloweryMethodHelper.currentUserToken ?? ""),
                );
              }
            },
          ),
        ],
        child: const CartPage(),
      ),
    );
  }
}





