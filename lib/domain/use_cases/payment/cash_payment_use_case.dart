import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/repositories/payment/cash_payment_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class CashPaymentUseCase{
  final CashPaymentRepo _cashPaymentRepo;
  CashPaymentUseCase(this._cashPaymentRepo);
 Future<Result<CashPaymentResponseEntity>>call({required PaymentRequestEntity request }){
  return _cashPaymentRepo.cashPayment(request: request);
} }

