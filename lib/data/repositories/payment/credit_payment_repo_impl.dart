import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/data/data_source/payment_data_source/credit_payment_data_source.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';
 import 'package:flowery_app/domain/repositories/payment/credit_payment_repo.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: CreditPaymentRepo)
class CreditPaymentRepoImpl implements CreditPaymentRepo{
  final CreditPaymentDataSource _creditPaymentDataSource;
  CreditPaymentRepoImpl(this._creditPaymentDataSource);


  @override
  Future<Result<CreditPaymentResponseEntity>> creditPayment(
      {
        required PaymentRequestEntity request,required String redirectUrl
      }      ) async{
     return await _creditPaymentDataSource.creditPayment(request:request , redirectUrl:redirectUrl) ;
  }
}