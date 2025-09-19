import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreditCheckoutWebView extends StatefulWidget {
  final String url;

  const CreditCheckoutWebView({super.key, required this.url});

  @override
  State<CreditCheckoutWebView> createState() => _CreditCheckoutWebViewState();
}

class _CreditCheckoutWebViewState extends State<CreditCheckoutWebView> {
  bool isLoading = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => isLoading = true),
          onPageFinished: (_) => setState(() => isLoading = false),
          onNavigationRequest: (request) {
            if (request.url.contains("allOrders")) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.floweryBottomNavigation,
                    (route) => route.isFirst,
              );
              Loaders.showSuccessMessage(message: AppText.yourPaymentHasBeenSuccessfullyProcessedAndYourOrderHasBeenPlaced.tr(), context: context);


              return NavigationDecision.prevent;
            }
            if (request.url.contains("cancel") ||
                request.url.contains("fail")) {
              Navigator.pop(context, false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credit Checkout'),
        bottom: isLoading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(3.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : null,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
