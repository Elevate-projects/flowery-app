
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';
import 'package:flowery_app/domain/use_cases/payment/credit_payment_use_case.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_intent.dart';
import 'package:flowery_app/presentation/payment/credit/view_model/credit_payment_state.dart';
import 'credit_payment_view_model_test.mocks.dart';

@GenerateMocks([CreditPaymentUseCase])
void main() {
  late MockCreditPaymentUseCase mockCreditPaymentUseCase;
  late CreditPaymentViewModel creditPaymentViewModel;

  final paymentRequest = PaymentRequestEntity();
  final sessionUrl = 'https://checkout.url';
  final redirectUrl = ConstKeys.redirectUrl;

  setUp(() {
    mockCreditPaymentUseCase = MockCreditPaymentUseCase();
    creditPaymentViewModel = CreditPaymentViewModel(mockCreditPaymentUseCase);

    // Provide dummy for Success generic
    provideDummy<Result<CreditPaymentResponseEntity>>(
        Success(CreditPaymentResponseEntity(session: SessionEntity(url: 'dummy'))));
  });

  blocTest<CreditPaymentViewModel, CreditPaymentState>(
    'should emit [Loading, Redirect] when use case succeeds with session url',
    build: () {
      when(mockCreditPaymentUseCase.call(paymentRequest, redirectUrl))
          .thenAnswer((_) async => Success(
          CreditPaymentResponseEntity(session: SessionEntity(url: sessionUrl))));
      return creditPaymentViewModel;
    },
    act: (cubit) => cubit.doIntent(
        OnCreditCheckoutClick(request: paymentRequest, redirectUrl: redirectUrl)),
    expect: () => [
      predicate<CreditPaymentState>((state) => state.paymentStatus.isLoading),
      predicate<CreditPaymentState>((state) =>
      state.paymentStatus.isSuccess && state.redirectUrl == sessionUrl),
    ],
  );

  blocTest<CreditPaymentViewModel, CreditPaymentState>(
    'should emit [Loading, Failure] when use case fails',
    build: () {
      when(mockCreditPaymentUseCase.call(paymentRequest, redirectUrl))
          .thenAnswer((_) async =>
          Failure(responseException: const ResponseException(message: 'API error')));
      return creditPaymentViewModel;
    },
    act: (cubit) => cubit.doIntent(
        OnCreditCheckoutClick(request: paymentRequest, redirectUrl: redirectUrl)),
    expect: () => [

    predicate<CreditPaymentState>((state) => state.paymentStatus.isLoading),
    predicate<CreditPaymentState>((state) =>
    state.paymentStatus.isFailure &&
        state.paymentStatus.error?.message == 'API error'),
    ],
  );

  blocTest<CreditPaymentViewModel, CreditPaymentState>(
    'should emit [IsCompleted] when redirect URL contains correct key',
    build: () => creditPaymentViewModel,
    act: (cubit) => cubit.doIntent(OnPaymentRedirect(url: 'https://example.com/allOrders')),
    expect: () => [
      predicate<CreditPaymentState>((state) => state.isCompleted),
    ],
  );

  blocTest<CreditPaymentViewModel, CreditPaymentState>(
    'should emit [isCancelled] when redirect URL contains cancel key',
    build: () => creditPaymentViewModel,
    act: (cubit) => cubit.doIntent(OnPaymentRedirect(url: 'https://example.com/cancel')),
    expect: () => [
      predicate<CreditPaymentState>((state) => state.isCancelled),
    ],
  );

}

