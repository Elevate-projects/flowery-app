
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/payment_data_source/cash_payment_data_source.dart';
import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/data/repositories/payment/cash_payment_repo_impl.dart';

import 'cash_payment_repo_impl_test.mocks.dart';

@GenerateMocks([CashPaymentDataSource])
void main() {
  late MockCashPaymentDataSource mockCashPaymentDataSource;
  late CashPaymentRepoImpl cashPaymentRepo;

  setUp(() {
    mockCashPaymentDataSource = MockCashPaymentDataSource();
    cashPaymentRepo = CashPaymentRepoImpl(mockCashPaymentDataSource);
  });

  setUpAll(() {
    provideDummy<Result<CashPaymentResponseEntity>>(Success(
      CashPaymentResponseEntity(message: 'dummy', order: null),
    ));
  });

  group('CashPaymentRepoImpl Tests', () {
    test(
        'should return Success<CashPaymentResponseEntity> when DataSource succeeds',
            () async {
          // Arrange
          final request = PaymentRequestEntity();
          final mockResponse = CashPaymentResponseEntity(message: 'Payment success');
          final mockResult = Success<CashPaymentResponseEntity>(mockResponse);

          when(mockCashPaymentDataSource.cashPayment(request: request))
              .thenAnswer((_) async => mockResult);

          // Act
          final result = await cashPaymentRepo.cashPayment(request: request);

          // Assert
          expect(result, isA<Success<CashPaymentResponseEntity>>());
          final success = result as Success<CashPaymentResponseEntity>;
          expect(success.data.message, 'Payment success');

          verify(mockCashPaymentDataSource.cashPayment(request: request)).called(1);
        });

    test(
        'should return Failure<CashPaymentResponseEntity> when DataSource fails',
            () async {
          // Arrange
          final request = PaymentRequestEntity();
          final mockResult = Failure<CashPaymentResponseEntity>(
            responseException: const ResponseException(message: 'API error'),
          );

          when(mockCashPaymentDataSource.cashPayment(request: request))
              .thenAnswer((_) async => mockResult);

          // Act
          final result = await cashPaymentRepo.cashPayment(request: request);

          // Assert
          expect(result, isA<Failure<CashPaymentResponseEntity>>());
          final failure = result as Failure<CashPaymentResponseEntity>;
          expect(failure.responseException.message, 'API error');

          verify(mockCashPaymentDataSource.cashPayment(request: request)).called(1);
        });
  });
}


