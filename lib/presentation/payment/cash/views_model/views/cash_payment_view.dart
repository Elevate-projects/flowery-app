// import 'package:flowery_app/presentation/payment/cash/views_model/cash_payment_view_model.dart';
//  import 'package:flowery_app/presentation/payment/cash/views_model/views/cash_payment_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flowery_app/core/di/di.dart';
//
// class CashPaymentView extends StatelessWidget {
//   const CashPaymentView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => getIt<CashPaymentViewModel>(),
//       child: BlocConsumer<CashPaymentViewModel, CashPaymentState>(
//         listener: (context, state) {
//           if (state is CashPaymentSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Cash order placed successfully!")),
//             );
//            } else if (state is CashPaymentFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("Error: ${state.message}")),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is CashPaymentLoading) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           }
//           return const SizedBox.shrink();
//
//          },
//       ),
//     );
//   }
// }
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/presentation/payment/cash/views_model/views/cash_payment_state.dart';
import 'package:flowery_app/presentation/payment/cash/views_model/cash_payment_view_model.dart';
import 'package:flowery_app/presentation/order_page/order_page.dart';

class CashPaymentView extends StatelessWidget {
  final List<CartItemEntity> cartItems;

  const CashPaymentView({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CashPaymentViewModel, CashPaymentState>(
      listener: (context, state) {
        if (state is CashPaymentSuccess) {
          Loaders.showSuccessMessage(
            message: state.response.message ?? "",
            context: context,
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => OrderPage(cartItems: cartItems)),
          );
        } else if (state is CashPaymentFailure) {
          Loaders.showErrorMessage(message: state.message, context: context);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
