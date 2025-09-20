import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';
 import 'package:flowery_app/domain/repositories/payment/credit_payment_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreditPaymentUseCase{
  final CreditPaymentRepo _creditPaymentRepo;
  CreditPaymentUseCase(this._creditPaymentRepo);
  Future<Result<CreditPaymentResponseEntity>>call( PaymentRequestEntity request ,String redirectUrl){
    return _creditPaymentRepo.creditPayment(request: request, redirectUrl: redirectUrl);
  }
}