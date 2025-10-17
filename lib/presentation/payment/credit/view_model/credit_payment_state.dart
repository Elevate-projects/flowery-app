import 'package:equatable/equatable.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';

class CreditPaymentState extends Equatable {
  final StateStatus<CreditPaymentResponseEntity?> paymentStatus;
  final String? redirectUrl;
  final bool isCompleted;
  final bool isCancelled;


  const CreditPaymentState({
    this.paymentStatus = const StateStatus.initial(),
    this.redirectUrl,
    this.isCompleted = false,
    this.isCancelled = false,

  });

  CreditPaymentState copyWith({
    StateStatus<CreditPaymentResponseEntity?>? paymentStatus,
    String? redirectUrl,
    bool? isCompleted,
    bool? isCancelled,

  }) {
    return CreditPaymentState(
      paymentStatus: paymentStatus ?? this.paymentStatus,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,

    );
  }

  @override
  List<Object?> get props => [paymentStatus, redirectUrl, isCompleted,isCancelled];
}
