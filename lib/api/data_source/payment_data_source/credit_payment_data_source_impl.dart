import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/client/request_maper.dart';
 import 'package:flowery_app/data/data_source/payment_data_source/credit_payment_data_source.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';
 import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CreditPaymentDataSource)
class CreditPaymentDataSourceImpl implements CreditPaymentDataSource {
  final ApiClient _apiClient;

  CreditPaymentDataSourceImpl(this._apiClient);

  @override
  Future<Result<CreditPaymentResponseEntity>> creditPayment(
      {
    required PaymentRequestEntity request,
    required String redirectUrl,
  }) async {
    return await executeApi(() async {

      final response = await _apiClient.creditPayment(
        request: RequestMapper.paymentToDto(request),
        token: "Bearer ${FloweryMethodHelper.currentUserToken}",
        redirectUrl: redirectUrl,
      );
      return response.creditPaymentToEntity();
    });
  }
}
