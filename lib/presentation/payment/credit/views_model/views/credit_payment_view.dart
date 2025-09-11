import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
 import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_intent.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_state.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/credit_payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CreditPaymentViewModel>(),
      child: BlocConsumer<CreditPaymentViewModel, CreditPaymentState>(
        listener: (BuildContext context, state) async {
          if (state is CreditPaymentSuccess) {
            final url = state.response.session?.url;
            if (url != null && url.isNotEmpty) {
               Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CheckoutWebView(url: url),
                ),
              );
            }
          } else if (state is CreditPaymentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: ${state.message}")),
            );
          }
        },
        builder: (BuildContext context, state) {
          if (state is CreditPaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Scaffold(
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
                  context
                      .read<CreditPaymentViewModel>().doIntent(
                      OnCreditCheckoutClick(request: request, redirectUrl: ConstKeys.redirectUrl));
                      
                },
                child: const Text("Pay Now"),
              ),
            ),
          );
        },
      ),
    );
  }
}

 class CheckoutWebView extends StatelessWidget {
  final String url;
  const CheckoutWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await launchUrlString(url,
              mode: LaunchMode.inAppWebView,
            );
          },
          child: const Text("Open Checkout"),
        ),
      ),
    );
  }
}
