
import 'package:flowery_app/presentation/payment/credit/views_model/credit_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
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
          onPageFinished: (url) {
            setState(() => isLoading = false);
            if (url.contains(ConstKeys.redirectUrl)) {
              context.read<CreditPaymentViewModel>().doIntent(
                OnPaymentRedirect(url: url),
              );
              Future.microtask(() => Navigator.pop(context));
            }
          },
          onWebResourceError: (error) {
            setState(() => isLoading = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to load page: ${error.description}")),
            );
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
          if (isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}