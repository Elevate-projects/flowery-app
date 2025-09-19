import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';

sealed class CashPaymentState {}

class CashPaymentInitial extends CashPaymentState {}

class CashPaymentLoading extends CashPaymentState {}

class CashPaymentSuccess extends CashPaymentState {
  final CashPaymentResponseEntity response;
  CashPaymentSuccess(this.response);
}

class CashPaymentFailure extends CashPaymentState {
  final String message;
  CashPaymentFailure(this.message);
}
