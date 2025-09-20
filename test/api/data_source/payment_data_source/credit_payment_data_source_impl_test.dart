import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/payment_data_source/credit_payment_data_source_impl.dart';
import 'package:flowery_app/api/responses/payment/credit/credit_payment_response_dto.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'credit_payment_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockConnectivity = MockConnectivity();
  ConnectionManager.connectivity = mockConnectivity;

  late MockApiClient mockApiClient;
  late CreditPaymentDataSourceImpl creditPaymentDataSource;

  final request = PaymentRequestEntity();
  final redirectUrl = "https://redirect.url";

  final responseDto = CreditPaymentResponseDto(
    message: 'Payment success',
    session: SessionDto(
      id: "sess_123",
      amountTotal: 1000,
      currency: "USD",
      status: "open",
      url: "https://checkout.url",
    ),
  );

  setUp(() {
    mockApiClient = MockApiClient();
    creditPaymentDataSource = CreditPaymentDataSourceImpl(mockApiClient);
  });

  group('CreditPaymentDataSourceImpl Tests', () {
    test('should return Success<CreditPaymentResponseEntity> when API succeeds', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(mockApiClient.creditPayment(
        request: anyNamed('request'),
        token: anyNamed('token'),
        redirectUrl: redirectUrl,
      )).thenAnswer((_) async => responseDto);

      // Act
      final result = await creditPaymentDataSource.creditPayment(
        request: request,
        redirectUrl: redirectUrl,
      );

      // Assert
      expect(result, isA<Success<CreditPaymentResponseEntity>>());
      final success = result as Success<CreditPaymentResponseEntity>;
      expect(success.data.message, 'Payment success');
      expect(success.data.session?.id, 'sess_123');

      verify(mockApiClient.creditPayment(
        request: anyNamed('request'),
        token: anyNamed('token'),
        redirectUrl: redirectUrl,
      )).called(1);
    });

  });
}
