import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flowery_app/api/client/api_client.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/api/data_source/payment_data_source/cash_payment_data_source_impl.dart';
import 'package:flowery_app/api/responses/payment/cash/cash_payment_response_dto.dart';
import 'package:flowery_app/core/connection_manager/connection_manager.dart';
import 'package:flowery_app/domain/entities/payment/cash/cash_payment_response_entity.dart';
import 'package:flowery_app/domain/entities/payment/credit/credit_payment_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cash_payment_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient, Connectivity])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockConnectivity = MockConnectivity();
  ConnectionManager.connectivity = mockConnectivity;

  late MockApiClient mockApiClient;
  late CashPaymentDataSourceImpl cashPaymentDataSource;

  final request = PaymentRequestEntity();

  final responseDto = CashPaymentResponseDto(
    message: 'Payment success',
  );

  setUp(() {
    mockApiClient = MockApiClient();
    cashPaymentDataSource = CashPaymentDataSourceImpl(mockApiClient);
  });

  group('CashPaymentDataSourceImpl Tests', () {
    test('should return Success<CashPaymentResponseEntity> when API succeeds', () async {
      // Arrange
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(mockApiClient.cashPayment(
        request: anyNamed('request'),
        token: anyNamed('token'),
      )).thenAnswer((_) async => responseDto);

      // Act
      final result = await cashPaymentDataSource.cashPayment(request: request);

      // Assert
      expect(result, isA<Success<CashPaymentResponseEntity>>());
      final success = result as Success<CashPaymentResponseEntity>;
      expect(success.data.message, 'Payment success');

      verify(mockApiClient.cashPayment(
        request: anyNamed('request'),
        token: anyNamed('token'),
      )).called(1);
    });


  });
}
