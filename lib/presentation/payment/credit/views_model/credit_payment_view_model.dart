import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
 import 'package:flowery_app/domain/use_cases/payment/credit_payment_use_case.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_intent.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/api/client/api_result.dart';
 import 'package:injectable/injectable.dart';

@injectable
class CreditPaymentViewModel extends Cubit<CreditPaymentState> {
  final CreditPaymentUseCase _creditPaymentUseCase;
   CreditPaymentViewModel(this._creditPaymentUseCase,
     )
    : super(CreditPaymentInitial());

  Future<void> doIntent(PaymentIntent intent) {
    switch (intent) {
      case OnCreditCheckoutClick():
        return _makePayment(intent.request, intent.redirectUrl);
      case OnPaymentRedirect():
        return _handleRedirect(intent.url);
    }
  }
  Future<void> _handleRedirect(String url) async {
     if (url.contains(ConstKeys.redirectUrl)) {
      emit(CreditPaymentCompleted());
    }
  }

  Future<void> _makePayment(
    PaymentRequestEntity request,
    String redirectUrl,
  ) async {
    emit(CreditPaymentLoading());

    final result = await _creditPaymentUseCase(request, redirectUrl);

    switch (result) {
      case Success(data: final response):
        emit(CreditPaymentSuccess(response));
      case Failure(responseException: final error):
        emit(CreditPaymentFailure(error.message));
    }
  }
}
