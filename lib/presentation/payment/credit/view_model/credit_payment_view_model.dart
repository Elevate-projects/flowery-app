import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
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
    : super(const CreditPaymentState());

  Future<void> doIntent(PaymentIntent intent) async {
    if (intent is OnCreditCheckoutClick) {
      await _makePayment(intent.request, intent.redirectUrl);
    } else if (intent is OnPaymentRedirect) {
      await _handleRedirect(intent.url);
    } else if (intent is OnPaymentCancel) {
      _handleCancel();
    }
  }

  Future<void> _handleRedirect(String url) async {
    if (url.contains("allOrders") || url.contains("success")) {
      emit(state.copyWith(isCompleted: true, redirectUrl: null));
    } else if (url.contains("cancel") || url.contains("fail")) {
      emit(state.copyWith(isCancelled: true, redirectUrl: null));
    }
  }

  void _handleCancel() {
    emit(state.copyWith(isCancelled: true, redirectUrl: null));
  }

  Future<void> _makePayment(
    PaymentRequestEntity request,
    String redirectUrl,
  ) async {
    emit(state.copyWith(paymentStatus: const StateStatus.loading()));

    final result = await _creditPaymentUseCase.call(request, redirectUrl);

    switch (result) {
      case Success(data: final response):
        final url = response.session?.url;
        if (url != null && url.isNotEmpty) {
          emit(
            state.copyWith(
              paymentStatus: StateStatus.success(response),
              redirectUrl: url,
            ),
          );
        } else {
          emit(
            state.copyWith(
              paymentStatus: const StateStatus.failure(
                ResponseException(message: AppText.invalidSessionURL),
              ),
            ),
          );
        }
      case Failure(responseException: final error):
        emit(state.copyWith(paymentStatus: StateStatus.failure(error)));
    }
  }

  void resetFlags() {
    emit(state.copyWith(isCompleted: false, isCancelled: false));
  }

  void clearRedirectUrl() {
    emit(state.copyWith(redirectUrl: null));
  }
}
