import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/use_cases/payment/credit_payment_use_case.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_intent.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreditPaymentViewModel extends Cubit<CreditPaymentState> {
  final CreditPaymentUseCase _creditPaymentUseCase;

  CreditPaymentViewModel(this._creditPaymentUseCase)
    : super(CreditPaymentInitial());

  Future<void> doIntent(PaymentIntent intent) async {
    if (intent is OnCreditCheckoutClick) {
      await _makePayment(intent.request, intent.redirectUrl);
    } else if (intent is OnPaymentRedirect) {
      await _handleRedirect(intent.url);
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

    final result = await _creditPaymentUseCase.call(request, redirectUrl);

    switch (result) {
      case Success(data: final response):
        final url = response.session?.url;
        if (url != null && url.isNotEmpty) {
          emit(CreditPaymentRedirect(url));
        } else {
          emit(CreditPaymentFailure(AppText.invalidSessionURL.tr()));
        }
      case Failure(responseException: final error):
        emit(CreditPaymentFailure(error.message));
    }
  }
}
