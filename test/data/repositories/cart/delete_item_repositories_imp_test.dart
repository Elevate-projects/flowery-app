import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/cart/remote_data_source_delete_item/remote_data_source_delete_item.dart';
import 'package:flowery_app/data/repositories/cart/delete_item_repo_imp/delete_item_repositories_imp.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_item_repositories_imp_test.mocks.dart';
@GenerateMocks([RemoteDataSourceDeleteItem])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final  DeleteItemRepositoriesImp cartRepositoryImpl;
  late final RemoteDataSourceDeleteItem remoteDataSourceQuantityRequest;
  setUpAll(() {
    remoteDataSourceQuantityRequest = MockRemoteDataSourceDeleteItem();
    cartRepositoryImpl = DeleteItemRepositoriesImp(remoteDataSourceQuantityRequest);
  });
  test('when call deleteCartItem it should return DeleteItemsEntity', () async {
    final expectedCart = const DeleteItemsEntity(
      message: "success",
      numOfCartItems: 10,

    );

    final expectedResult = Success(expectedCart);
    provideDummy<Result<DeleteItemsEntity>>(expectedResult);
    when(remoteDataSourceQuantityRequest.deleteCartItem("id123"))
        .thenAnswer((_) async => expectedResult);
    final result = await cartRepositoryImpl.deleteCartItem("id123");
    expect(result, isA<Success<DeleteItemsEntity>>());
    expect(result, expectedResult);
  });

}