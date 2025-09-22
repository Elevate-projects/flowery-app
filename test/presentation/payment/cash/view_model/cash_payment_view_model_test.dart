
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/presentation/payment/cash/view_model/cash_payment_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/use_cases/payment/cash_payment_use_case.dart';
import 'package:flowery_app/presentation/payment/cash/view_model/cash_payment_intent.dart';
import 'package:flowery_app/presentation/payment/cash/view_model/cash_payment_state.dart';
import 'cash_payment_view_model_test.mocks.dart';
@GenerateMocks([CashPaymentUseCase])
void main() {
  late MockCashPaymentUseCase mockCashPaymentUseCase;
  late CashPaymentViewModel cashPaymentViewModel;

  final paymentRequest = PaymentRequestEntity();
  final cashResponse = CashPaymentResponseEntity(message: 'Payment success');

  setUp(() {
    mockCashPaymentUseCase = MockCashPaymentUseCase();
    cashPaymentViewModel = CashPaymentViewModel(mockCashPaymentUseCase);

    provideDummy<Result<CashPaymentResponseEntity>>(
      Success(CashPaymentResponseEntity(message: 'dummy')),
    );
  });

  blocTest<CashPaymentViewModel, CashPaymentState>(
    'should emit [Loading, Success] when use case succeeds',
    build: () {
      when(mockCashPaymentUseCase.call(request: paymentRequest))
          .thenAnswer((_) async => Success(cashResponse));
      return cashPaymentViewModel;
    },
    act: (cubit) =>
        cubit.doIntent(OnCashCheckoutClick(request: paymentRequest)),
    expect: () =>
    [
      isA<CashPaymentLoading>(),
      isA<CashPaymentSuccess>().having((s) => s.response.message, 'message',
          'Payment success'),
    ],
  );

  blocTest<CashPaymentViewModel, CashPaymentState>(
    'should emit [Loading, Failure] when use case fails',
    build: () {
      when(mockCashPaymentUseCase.call(request: paymentRequest))
          .thenAnswer((_) async =>
          Failure(
            responseException: const ResponseException(message: 'API error'),
          ));
      return cashPaymentViewModel;
    },
    act: (cubit) =>
        cubit.doIntent(OnCashCheckoutClick(request: paymentRequest)),
    expect: () =>
    [
      isA<CashPaymentLoading>(),
      isA<CashPaymentFailure>().having((f) => f.message, 'message',
          'API error'),
    ],
  );
}
