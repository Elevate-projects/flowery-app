import 'package:flowery_app/domain/entities/cart/cart_item_entity/cart_item_entity.dart';
import 'package:flowery_app/presentation/payment/credit/view/widgets/credit_checkout_web_view.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_view_model.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_state.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/router/route_names.dart';

class CreditPaymentViewBody extends StatelessWidget {
  final List<CartItemEntity> cartItems;

  const CreditPaymentViewBody({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
  return  BlocConsumer<CreditPaymentViewModel, CreditPaymentState>(
    listener: (context, state) {
      if (state.redirectUrl != null) {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CreditCheckoutWebView(url: state.redirectUrl!),
          ),
        );
        context.read<CreditPaymentViewModel>().clearRedirectUrl();
      } else if (state.paymentStatus.isSuccess &&
          state.paymentStatus.data != null) {
        Loaders.showSuccessMessage(
          message: state.paymentStatus.data?.message ?? '',
          context: context,
        );
      } else if (state.paymentStatus.isFailure) {
        Loaders.showErrorMessage(
          message:
          state.paymentStatus.error?.message ?? 'Something went wrong',
          context: context,
        );
      } else if (state.isCompleted) {
        debugPrint("✅ Payment Completed, navigating to Home...");

        WidgetsBinding.instance.addPostFrameCallback((_)
        {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.floweryBottomNavigation,
                (route) => false,);
        });
        Loaders.showSuccessMessage(message:
        AppText.yourPaymentHasBeenSuccessfullyProcessedAndYourOrderHasBeenPlaced.tr(),
            context: context);

        context.read<CreditPaymentViewModel>().resetFlags();
      } else if (state.isCancelled) {
        Navigator.pop(context, false);
        Loaders.showErrorMessage(
          message: "Payment was cancelled",
          context: context,
        );
        context.read<CreditPaymentViewModel>().resetFlags();
      }
    },

    builder: (context, state) {
      if (state.paymentStatus.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      return const SizedBox.shrink();
    },
  );
  }
}