class CreditPaymentResponseEntity {
  final String? message;
  final SessionEntity? session;

  CreditPaymentResponseEntity({
    this.message,
    this.session,
  });
}

class SessionEntity {
  final String? id;
  final int? amountTotal;
  final String? currency;
  final String? status;
  final String? url;

  SessionEntity({
    this.id,
    this.amountTotal,
    this.currency,
    this.status,
    this.url,
  });

}
