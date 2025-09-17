import 'package:easy_localization/easy_localization.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/enum/payment_method.dart';
import 'package:flowery_app/presentation/payment/cash/view_model/cash_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/cash/view_model/cash_payment_intent.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_intent.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentMethod?> {

  PaymentCubit() : super(null);

  void selectMethod(PaymentMethod method) => emit(method);

  Future<void> confirmOrder({required BuildContext context}) async {
    final method = state;

    if (method == null) {

      Loaders.showSuccessMessage(message: AppText.pleaseSelectAPaymentMethod.tr(), context: context);


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
