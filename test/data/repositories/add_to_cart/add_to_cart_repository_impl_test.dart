import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/add_to_cart/remote_data_source/add_to_cart_remote_data_source.dart';
import 'package:flowery_app/data/repositories/add_to_cart/add_to_cart_repository_impl.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_to_cart_repository_impl_test.mocks.dart';

@GenerateMocks([AddToCartRemoteDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockAddToCartRemoteDataSource mockAddToCartRemoteDataSource;
  late final AddToCartRepositoryImpl addToCartRepositoryImpl;
  late final AddToCartRequestEntity request;

  setUpAll(() {
    mockAddToCartRemoteDataSource = MockAddToCartRemoteDataSource();
    addToCartRepositoryImpl = AddToCartRepositoryImpl(
      mockAddToCartRemoteDataSource,
    );
    request = AddToCartRequestEntity(productId: "202556", quantity: 5);
  });
  test(
    'when call addProductToCart it should be called successfully from AddToCartRemoteDataSource',
    () async {
      // Arrange
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockAddToCartRemoteDataSource.addProductToCart(request: request),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await addToCartRepositoryImpl.addProductToCart(
        request: request,
      );
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(
        mockAddToCartRemoteDataSource.addProductToCart(request: request),
      ).called(1);
    },
  );
}
