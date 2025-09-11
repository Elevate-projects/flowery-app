import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';

sealed class PaymentIntent{}
class OnCreditCheckoutClick extends PaymentIntent{
  PaymentRequestEntity request;
  String redirectUrl;

  OnCreditCheckoutClick({ required this.request,required this.redirectUrl});
}
class OnPaymentRedirect extends PaymentIntent {
  final String url;

  OnPaymentRedirect({required this.url});
}