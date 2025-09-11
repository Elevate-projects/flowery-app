import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';

sealed class CashPaymentIntent {}

class OnCashCheckoutClick extends CashPaymentIntent {
  final PaymentRequestEntity request;
  OnCashCheckoutClick({required this.request});
}
