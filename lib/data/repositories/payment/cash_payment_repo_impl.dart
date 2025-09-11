import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/payment_data_source/cash_payment_data_source.dart';
import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/repositories/payment/cash_payment_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CashPaymentRepo)
class CashPaymentRepoImpl implements CashPaymentRepo {
  final CashPaymentDataSource _cashPaymentDataSource;

  CashPaymentRepoImpl(this._cashPaymentDataSource);

  @override
  Future<Result<CashPaymentResponseEntity>> cashPayment({
    required PaymentRequestEntity request,
  }) {
    return _cashPaymentDataSource.cashPayment(request: request);
  }
}
