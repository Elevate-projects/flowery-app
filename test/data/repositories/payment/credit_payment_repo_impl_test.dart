
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/payment_data_source/credit_payment_data_source.dart';
import 'package:flowery_app/data/repositories/payment/credit_payment_repo_impl.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';

import 'credit_payment_repo_impl_test.mocks.dart';

@GenerateMocks([CreditPaymentDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
      'should return Success<CreditPaymentResponseEntity> and call data source when API call succeeds',
          () async {
        final mockDataSource = MockCreditPaymentDataSource();
        final CreditPaymentRepoImpl repo = CreditPaymentRepoImpl(mockDataSource);

        final request = PaymentRequestEntity();
        final redirectUrl = 'https://redirect.url';

        final expectedResponse = CreditPaymentResponseEntity(
          message: 'Payment success',
          session: null,
        );

        final expectedResult = Success(expectedResponse);

        provideDummy<Result<CreditPaymentResponseEntity>>(expectedResult);

        when(mockDataSource.creditPayment(request: request, redirectUrl: redirectUrl))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await repo.creditPayment(request: request, redirectUrl: redirectUrl);

        // Assert
        verify(mockDataSource.creditPayment(request: request, redirectUrl: redirectUrl))
            .called(1);

        expect(result, isA<Success<CreditPaymentResponseEntity>>());

        result as Success<CreditPaymentResponseEntity>;

        expect(result.data.message, equals(expectedResponse.message));
      });

  test(
      'should return Failure<CreditPaymentResponseEntity> and call data source when API call fails',
          () async {
        final mockDataSource = MockCreditPaymentDataSource();
        final CreditPaymentRepoImpl repo = CreditPaymentRepoImpl(mockDataSource);

        final request = PaymentRequestEntity();
        final redirectUrl = 'https://redirect.url';

        final expectedFailure = Failure<CreditPaymentResponseEntity>(
          responseException: const ResponseException(message: 'API error'),
        );

        provideDummy<Result<CreditPaymentResponseEntity>>(expectedFailure);

        when(mockDataSource.creditPayment(request: request, redirectUrl: redirectUrl))
            .thenAnswer((_) async => expectedFailure);

        // Act
        final result = await repo.creditPayment(request: request, redirectUrl: redirectUrl);

        // Assert
        verify(mockDataSource.creditPayment(request: request, redirectUrl: redirectUrl))
            .called(1);

        expect(result, isA<Failure<CreditPaymentResponseEntity>>());

        result as Failure<CreditPaymentResponseEntity>;

        expect(result.responseException.message, contains('API error'));
      });
}


