import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';

abstract interface class CashPaymentDataSource{
  Future<Result<CashPaymentResponseEntity>>cashPayment(
      {required  PaymentRequestEntity request
      }      );
}