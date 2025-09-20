
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';
import 'package:flowery_app/domain/repositories/payment/credit_payment_repo.dart';
import 'package:flowery_app/domain/use_cases/payment/credit_payment_use_case.dart';

import 'credit_payment_use_case_test.mocks.dart';

@GenerateMocks([CreditPaymentRepo])
void main() {
  late MockCreditPaymentRepo mockCreditPaymentRepo;
  late CreditPaymentUseCase creditPaymentUseCase;

  setUp(() {
    mockCreditPaymentRepo = MockCreditPaymentRepo();
    creditPaymentUseCase = CreditPaymentUseCase(mockCreditPaymentRepo);
  });

  setUpAll(() {
    provideDummy<Result<CreditPaymentResponseEntity>>(Success(
      CreditPaymentResponseEntity(message: 'dummy', session: null),
    ));
  });

  group('CreditPaymentUseCase Tests', () {
    test(
        'should return Success<CreditPaymentResponseEntity> when repo succeeds',
            () async {
          // Arrange
          final request = PaymentRequestEntity();
          final redirectUrl = "https://redirect.url";
          final mockResponse = CreditPaymentResponseEntity(
            message: 'Payment success',
            session: null,
          );
          final mockResult = Success<CreditPaymentResponseEntity>(mockResponse);

          when(mockCreditPaymentRepo.creditPayment(
            request: request,
            redirectUrl: redirectUrl,
          )).thenAnswer((_) async => mockResult);

          // Act
          final result = await creditPaymentUseCase.call(
            request,
            redirectUrl,
          );

          // Assert
          expect(result, isA<Success<CreditPaymentResponseEntity>>());
          final success = result as Success<CreditPaymentResponseEntity>;
          expect(success.data.message, 'Payment success');

          verify(mockCreditPaymentRepo.creditPayment(
            request: request,
            redirectUrl: redirectUrl,
          )).called(1);
        });

    test(
        'should return Failure<CreditPaymentResponseEntity> when repo fails',
            () async {
          // Arrange
          final request = PaymentRequestEntity();
          final redirectUrl = "https://redirect.url";
          final mockResult = Failure<CreditPaymentResponseEntity>(
            responseException: const ResponseException(message: 'API error'),
          );

          when(mockCreditPaymentRepo.creditPayment(
            request: request,
            redirectUrl: redirectUrl,
          )).thenAnswer((_) async => mockResult);

          // Act
          final result = await creditPaymentUseCase.call(
            request,
            redirectUrl,
          );

          // Assert
          expect(result, isA<Failure<CreditPaymentResponseEntity>>());
          final failure = result as Failure<CreditPaymentResponseEntity>;

          verify(mockCreditPaymentRepo.creditPayment(
            request: request,
            redirectUrl: redirectUrl,
          )).called(1);
        });
  });
}
