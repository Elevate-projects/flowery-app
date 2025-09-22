import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/get_user_order/remote_data_source/get_user_order_data_source.dart';
import 'package:flowery_app/data/repositories/get_user_order/get_user_order_repositories_imp.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_item_entity/order_item_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_order_repositories_imp_test.mocks.dart';
@GenerateMocks([GetUserOrderDataSource])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late final GetUserOrderRepositoriesImp getUserOrderRepositoriesImp;
  late final GetUserOrderDataSource getUserOrderDataSource;
  setUpAll(() {
    getUserOrderDataSource = MockGetUserOrderDataSource();
    getUserOrderRepositoriesImp = GetUserOrderRepositoriesImp(getUserOrderDataSource);
  });
  test(
    'when call GetUserOrderRepositoriesImp it should be called successfully from RemoteDataSourceGetUserOrder and return GetUserOrderEntity',
        () async {
      final mockorderentity = OrderEntity(
        id: "123",
        user: "123",
        orderItems: [
          OrderItemEntity(
            id: "www",
            price: 0,
            product: const ProductCardEntity(
              productId: "ss",
              title: "123",
              imgCover: "123",
              description: "123",
            )
          )
        ],
      );
      provideDummy<Result<List<OrderEntity>>>(Success([mockorderentity]));
      when(getUserOrderDataSource.getUserOrder())
          .thenAnswer((_) async => Success([mockorderentity]));
      final result = await getUserOrderRepositoriesImp.getUserOrder();
      verify(getUserOrderDataSource.getUserOrder()).called(1);
      expect(result, isA<Success<List<OrderEntity>>>());
      final successResult = result as Success<List<OrderEntity>>;
      expect(successResult.data.first.id, mockorderentity.id);
      expect(result, isA<Success<List<OrderEntity>>>());

    },
  );

}