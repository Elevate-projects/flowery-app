import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_intent.dart';

class CreditCheckoutWebView extends StatelessWidget {
  final String url;

  const CreditCheckoutWebView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final url = request.url;

            if (url.contains("allOrders") || url.contains("success")) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.floweryBottomNavigation,
                (route) => false,
              );
              // context.read<CreditPaymentViewModel>().doIntent(
              //   OnPaymentRedirect(url: url),
              // );
              Loaders.showSuccessMessage(
                message: AppText
                    .yourPaymentHasBeenSuccessfullyProcessedAndYourOrderHasBeenPlaced
                    .tr(),
                context: context,
              );
              return NavigationDecision.prevent;
            }

            if (url.contains("cancel") || url.contains("fail")) {
              context.read<CreditPaymentViewModel>().doIntent(
                OnPaymentCancel(),
              );
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(title: const Text('Credit Checkout')),
      body: WebViewWidget(controller: controller),
    );
  }
}
