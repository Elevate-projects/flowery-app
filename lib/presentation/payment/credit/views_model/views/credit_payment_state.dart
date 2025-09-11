import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';

sealed class CreditPaymentState {}

class CreditPaymentInitial extends CreditPaymentState {}

class CreditPaymentLoading extends CreditPaymentState {}

class CreditPaymentRedirect extends CreditPaymentState {
  final String url;
  CreditPaymentRedirect(this.url);
}

class CreditPaymentSuccess extends CreditPaymentState {
  final CreditPaymentResponseEntity response;
  CreditPaymentSuccess(this.response);
}

class CreditPaymentFailure extends CreditPaymentState {
  final String message;
  CreditPaymentFailure(this.message);
}

class CreditPaymentCompleted extends CreditPaymentState {}
