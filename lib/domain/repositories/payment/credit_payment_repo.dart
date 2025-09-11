import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';

abstract interface class CreditPaymentRepo{

  Future<Result<CreditPaymentResponseEntity>>creditPayment(
      {
   required PaymentRequestEntity request,
   required String redirectUrl,
  });
}