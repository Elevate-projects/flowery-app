import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';
import 'package:flowery_app/domain/repositories/add_to_cart/add_to_cart_repository.dart';
import 'package:flowery_app/domain/use_cases/add_to_cart/add_product_to_cart_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_product_to_cart_use_case_test.mocks.dart';

@GenerateMocks([AddToCartRepository])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final MockAddToCartRepository mockAddToCartRepository;
  late final AddProductToCartUseCase addProductToCartUseCase;
  late final AddToCartRequestEntity request;

  setUpAll(() {
    mockAddToCartRepository = MockAddToCartRepository();
    addProductToCartUseCase = AddProductToCartUseCase(mockAddToCartRepository);
    request = AddToCartRequestEntity(productId: "202556", quantity: 5);
  });
  test(
    'when call addProductToCart it should be called successfully from AddToCartRepository',
    () async {
      // Arrange
      final expectedResult = Success(null);
      provideDummy<Result<void>>(expectedResult);
      when(
        mockAddToCartRepository.addProductToCart(request: request),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await addProductToCartUseCase.invoke(request: request);
      final successResult = result as Success<void>;

      // Assert
      expect(successResult, isA<Success<void>>());
      verify(
        mockAddToCartRepository.addProductToCart(request: request),
      ).called(1);
    },
  );
}
