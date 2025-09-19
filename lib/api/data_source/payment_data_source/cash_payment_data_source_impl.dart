import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
import 'package:flowery_app/data/data_source/payment_data_source/cash_payment_data_source.dart';
import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CashPaymentDataSource)
class CashPaymentDataSourceImpl implements CashPaymentDataSource {
  final ApiClient _apiClient;

  CashPaymentDataSourceImpl(this._apiClient);

  @override
  Future<Result<CashPaymentResponseEntity>> cashPayment(
      {
    required PaymentRequestEntity request,
  }) async {
    return await executeApi(() async {
      final response = await _apiClient.cashPayment(
        request: RequestMapper.paymentToDto(request),
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
      );
      return response.cashPaymentToEntity();
    });
  }
}
