// import 'package:flowery_app/core/constants/const_keys.dart';
// import 'package:flowery_app/core/di/di.dart';
// import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_intent.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_state.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/credit_payment_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher_string.dart';
//
// class CreditPaymentView extends StatelessWidget {
//   const CreditPaymentView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => getIt<CreditPaymentViewModel>(),
//       child: BlocConsumer<CreditPaymentViewModel, CreditPaymentState>(
//         listener: (BuildContext context, state) async {
//           if (state is CreditPaymentRedirect) {
//             await launchUrlString(state.url, mode: LaunchMode.inAppWebView);
//           } else if (state is CreditPaymentFailure) {
//             ScaffoldMessenger.of(
//               context,
//             ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
//           }
//         },
//         builder: (BuildContext context, state) {
//           if (state is CreditPaymentLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
//
// // class CheckoutWebView extends StatelessWidget {
// //   final String url;
// //
// //   const CheckoutWebView({super.key, required this.url});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: ElevatedButton(
// //           onPressed: () async {
// //             final request = PaymentRequestEntity(
// //               shippingAddress: ShippingAddressEntity(
// //                 street: '4s down town',
// //                 phone: '0123456789',
// //                 long: 'long',
// //                 lat: 'lat',
// //                 city: 'cairo',
// //               ),
// //             );
// //
// //             context.read<CreditPaymentViewModel>().doIntent(
// //               OnCreditCheckoutClick(
// //                 request: request,
// //                 redirectUrl: ConstKeys.redirectUrl,
// //               ),
// //             );
// //
// //             await launchUrlString(url, mode: LaunchMode.inAppWebView);
// //           },
// //           child: const Text("Open Checkout"),
// //         ),
// //       ),
// //     );
// //   }
// // }

//
// import 'package:flowery_app/core/constants/const_keys.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_intent.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/credit_payment_view_model.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_state.dart';
// import 'package:flowery_app/presentation/order_page/order_page.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class CreditPaymentView extends StatelessWidget {
//   const CreditPaymentView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CreditPaymentViewModel, CreditPaymentState>(
//       listener: (context, state) async {
//         if (state is CreditPaymentRedirect) {
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => CreditCheckoutWebView(url: state.url),
//               ),
//             );
//         } else if (state is CreditPaymentFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Error: ${state.message}")),
//           );
//         } else if (state is CreditPaymentCompleted) {
//           // سيرفر أكّد الدفع (مثال) — نودّي صفحة الأوردر
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Payment completed")),
//           );
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (_) => const OrderPage(cartItems: [],)),
//           );
//         }
//       },
//       child: const SizedBox.shrink(),
//     );
//   }
// }
//
//
//
//
//
// class CreditCheckoutWebView extends StatelessWidget {
//   final String url;
//   const CreditCheckoutWebView({super.key, required this.url});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Credit Checkout')),
//       body:
//       WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//         navigationDelegate: (nav) {
//           if (nav.url.contains(ConstKeys.redirectUrl)) {
//              context.read<CreditPaymentViewModel>().doIntent(
//               OnPaymentRedirect(url: nav.url),
//             );
//             Navigator.pop(context);
//           }
//           return NavigationDecision.navigate;
//         },
//       ),
//     );
//   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flowery_app/core/constants/const_keys.dart';
// import 'package:flowery_app/presentation/order_page/order_page.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/credit_payment_view_model.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_state.dart';
// import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_intent.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class CreditPaymentView extends StatelessWidget {
//   const CreditPaymentView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CreditPaymentViewModel, CreditPaymentState>(
//       listener: (context, state) {
//         if (state is CreditPaymentRedirect) {
//           // افتح صفحة الدفع بالـ WebView
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => CreditCheckoutWebView(url: state.url),
//             ),
//           );
//         } else if (state is CreditPaymentFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text("Error: ${state.message}")),
//           );
//         } else if (state is CreditPaymentCompleted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Payment completed")),
//         );
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (_) => const OrderPage(cartItems: [])),
//         );
//         }
//       },
//       child: const SizedBox.shrink(),
//     );
//   }
// }
//
// class CreditCheckoutWebView extends StatefulWidget {
//   final String url;
//   const CreditCheckoutWebView({super.key, required this.url});
//
//   @override
//   State<CreditCheckoutWebView> createState() => _CreditCheckoutWebViewState();
// }
//
// class _CreditCheckoutWebViewState extends State<CreditCheckoutWebView> {
//   late final WebViewController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onNavigationRequest: (nav) {
//              if (nav.url.contains(ConstKeys.redirectUrl)) {
//               context.read<CreditPaymentViewModel>().doIntent(
//                 OnPaymentRedirect(url: nav.url),
//               );
//              }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Credit Checkout')),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/widgets/credit_checkout_web_view.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/credit_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_state.dart';
import 'package:flowery_app/presentation/order_page/order_page.dart';

class CreditPaymentView extends StatelessWidget {
  final List<CartItemEntity> cartItems;

  const CreditPaymentView({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreditPaymentViewModel, CreditPaymentState>(
      listener: (context, state) {
        if (state is CreditPaymentRedirect) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CreditCheckoutWebView(url: state.url),
            ),
          );
        } else if (state is CreditPaymentSuccess) {
          Loaders.showSuccessMessage(
            message: state.response.message ?? '',
            context: context,
          );
        } else if (state is CreditPaymentFailure) {
          Loaders.showErrorMessage(message: state.message, context: context);
        } else if (state is CreditPaymentCompleted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(  SnackBar(content: Text(AppText.paymentCompleted.tr())));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => OrderPage(cartItems: cartItems)),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
