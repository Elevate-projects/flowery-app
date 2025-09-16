import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/enum/payment_method.dart';
import 'package:flowery_app/presentation/payment/cash/views_model/cash_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/cash/views_model/views/cash_payment_intent.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/credit_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/credit/views_model/views/credit_payment_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// enum PaymentMethod { none, cash, credit }
//
// class PaymentState {
//   final PaymentMethod method;
//   const PaymentState({this.method = PaymentMethod.none});
//
//   PaymentState copyWith({PaymentMethod? method}) {
//     return PaymentState(method: method ?? this.method);
//   }
// }
//
// class PaymentCubit extends Cubit<PaymentState> {
//   PaymentCubit() : super(const PaymentState());
//
//   void selectPayment(PaymentMethod method) {
//     emit(state.copyWith(method: method));
//   }
// }





class PaymentCubit extends Cubit<PaymentMethod?> {

  PaymentCubit() : super(null);

  void selectMethod(PaymentMethod method) => emit(method);

  Future<void> confirmOrder({required BuildContext context}) async {
    final method = state;

    if (method == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text( AppText.pleaseSelectAPaymentMethod.tr())),
      );
      return;
    }

    final request = PaymentRequestEntity(
      shippingAddress: ShippingAddressEntity(
        street: '4s down town',
        phone: '0123456789',
        long: 'long',
        lat: 'lat',
        city: 'cairo',
      ),
    );

    if (method == PaymentMethod.cash) {
      context.read<CashPaymentViewModel>().doIntent(
        OnCashCheckoutClick(request: request),
      );
    } else if (method == PaymentMethod.credit) {
      context.read<CreditPaymentViewModel>().doIntent(
        OnCreditCheckoutClick(
          request: request,
          redirectUrl: ConstKeys.redirectUrl,
        ),
      );
    }
  }
}
