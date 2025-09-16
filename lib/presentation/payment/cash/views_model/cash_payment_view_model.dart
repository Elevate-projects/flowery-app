import 'package:flowery_app/domain/use_cases/payment/cash_payment_use_case.dart';
import 'package:flowery_app/presentation/payment/cash/views_model/views/cash_payment_intent.dart';
import 'package:flowery_app/presentation/payment/cash/views_model/views/cash_payment_state.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:injectable/injectable.dart';

@injectable
class CashPaymentViewModel extends Cubit<CashPaymentState> {
   final CashPaymentUseCase _cashPaymentUseCase;
   CashPaymentViewModel(this._cashPaymentUseCase)
      : super(CashPaymentInitial());

   Future<void> doIntent(OnCashCheckoutClick intent) async {
     emit(CashPaymentLoading());

     final result = await _cashPaymentUseCase.call(request: intent.request);

     switch (result) {
       case Success(data: final response):
         emit(CashPaymentSuccess(response));
       case Failure(responseException: final error):
         emit(CashPaymentFailure(error.message));
     }
   }

}


