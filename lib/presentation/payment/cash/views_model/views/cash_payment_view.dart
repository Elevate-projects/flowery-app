import 'package:flowery_app/presentation/payment/cash/views_model/cash_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/cash/views_model/views/cash_payment_intent.dart';
import 'package:flowery_app/presentation/payment/cash/views_model/views/cash_payment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';

class CashPaymentView extends StatelessWidget {
  const CashPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CashPaymentViewModel>(),
      child: BlocConsumer<CashPaymentViewModel, CashPaymentState>(
        listener: (context, state) {
          if (state is CashPaymentSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Cash order placed successfully!")),
            );
            Navigator.pop(context);
          } else if (state is CashPaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        builder: (context, state) {
          if (state is CashPaymentLoading) {
            return const  Center(child: CircularProgressIndicator(),);
          }

          return Scaffold(
            appBar: AppBar(title: const Text("Cash Payment")),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  final request = PaymentRequestEntity(
                    shippingAddress: ShippingAddressEntity(
                      street: '4s down town',
                      phone: '0123456789',
                      long: 'long',
                      lat: 'lat',
                      city: 'cairo',
                    ),
                  );

                  context.read<CashPaymentViewModel>().doIntent(
                    OnCashCheckoutClick(request: request),
                  );
                },
                child: const Text("Pay Cash on Delivery"),
              ),
            ),
          );
        },
      ),
    );
  }
}
