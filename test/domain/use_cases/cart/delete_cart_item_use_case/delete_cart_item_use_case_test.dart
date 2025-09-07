import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:flowery_app/domain/repositories/cart/delete_item_repositories/delete_item_repositories.dart';
import 'package:flowery_app/domain/use_cases/cart/delete_cart_item_use_case/delete_cart_item_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_cart_item_use_case_test.mocks.dart';
@GenerateMocks([DeleteItemRepositories])
// 1- moc Dependency injection
void main() {
  test('when I call deleteCartItem it should be called successfully', ()async {
    //2- moc class test
    final mockedDeleteItemRepositories = MockDeleteItemRepositories();
    //3- call use case and give it moc class
    final deleteCartItemUseCase = DeleteCartItemUseCase(mockedDeleteItemRepositories
    );
    // 4- call function return value
    final expectedDeleteCartItemEntity = const DeleteItemsEntity(
      message: "ok",
      numOfCartItems: 1,
    );
    // 5- check if function return value is correct
    final expectedDeleteCartItemResult = Success(expectedDeleteCartItemEntity);
    provideDummy<Result<DeleteItemsEntity>>(expectedDeleteCartItemResult);
    when(
      mockedDeleteItemRepositories.deleteCartItem("productId", "token"),
    ).thenAnswer((_) async => expectedDeleteCartItemResult);
    final result = await deleteCartItemUseCase.deleteCartItem("productId", "token");
    final successResult = result as Success<DeleteItemsEntity>;
    expect(result, isA<Success<DeleteItemsEntity>>());
    verify(mockedDeleteItemRepositories.deleteCartItem("productId", "token")).called(1);
    expect(
      expectedDeleteCartItemResult.data.message,
      equals(successResult.data.message),
    );
  });
}