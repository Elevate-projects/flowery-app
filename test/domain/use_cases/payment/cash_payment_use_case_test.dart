import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/repositories/payment/cash_payment_repo.dart';
import 'package:flowery_app/domain/use_cases/payment/cash_payment_use_case.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';

import 'cash_payment_use_case_test.mocks.dart';

@GenerateMocks([CashPaymentRepo])
void main() {
  late MockCashPaymentRepo mockCashPaymentRepo;
  late CashPaymentUseCase cashPaymentUseCase;

  setUp(() {
    mockCashPaymentRepo = MockCashPaymentRepo();
    cashPaymentUseCase = CashPaymentUseCase(mockCashPaymentRepo);
  });

  setUpAll(() {
    provideDummy<Result<CashPaymentResponseEntity>>(Success(
      CashPaymentResponseEntity(message: 'dummy'),
    ));
  });

  group('CashPaymentUseCase Tests', () {
    test(
        'should return Success<CashPaymentResponseEntity> when repo succeeds',
            () async {
          // Arrange
          final request = PaymentRequestEntity();
          final mockResponse =
          CashPaymentResponseEntity(message: 'Payment success');
          final mockResult = Success<CashPaymentResponseEntity>(mockResponse);

          when(mockCashPaymentRepo.cashPayment(request: request))
              .thenAnswer((_) async => mockResult);

          // Act
          final result = await cashPaymentUseCase.call(request: request);

          // Assert
          expect(result, isA<Success<CashPaymentResponseEntity>>());
          final success = result as Success<CashPaymentResponseEntity>;
          expect(success.data.message, 'Payment success');

          verify(mockCashPaymentRepo.cashPayment(request: request)).called(1);
        });

    test(
        'should return Failure<CashPaymentResponseEntity> when repo fails',
            () async {
          // Arrange
          final request = PaymentRequestEntity();
          final mockResult = Failure<CashPaymentResponseEntity>(
            responseException: const ResponseException(message: 'API error'),
          );

          when(mockCashPaymentRepo.cashPayment(request: request))
              .thenAnswer((_) async => mockResult);

          // Act
          final result = await cashPaymentUseCase.call(request: request);

          // Assert
          expect(result, isA<Failure<CashPaymentResponseEntity>>());
          final failure = result as Failure<CashPaymentResponseEntity>;
          expect(failure.responseException.message, 'API error');

          verify(mockCashPaymentRepo.cashPayment(request: request)).called(1);
        });
  });
}
