import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/data/data_source/get_user_order/remote_data_source/get_user_order_data_source.dart';
import 'package:flowery_app/data/repositories/get_user_order/get_user_order_repositories_imp.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';
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
      final expectedCart = GetUserOrderEntity(
        message: "success",
        metadata: MetadataEntity(
          currentPage: 1,
          totalPages: 10,
          limit: 10,
          totalItems: 100,
        ),
        orders: [
          OrderEntity(
            id: "673c46fd1159920171827c85",
            user: "673c46fd1159920185",
            orderItems: [
              OrderItemEntity(
                product: ProductEntity(
                  id: "673c46fd1159920185",
                  title: "Red Rose Bouquet",
                  imgCover: "https://example.com/images/red_rose_cover.jpg",
                  price: 0,
                  priceAfterDiscount: 0,
                  quantity: 0,
                ),
              ),
            ],
          )
        ],
      );

      final expectedResult = Success(expectedCart);
      provideDummy<Result<GetUserOrderEntity>>(expectedResult);

      when(getUserOrderDataSource.getUserOrder())
          .thenAnswer((_) async => expectedResult);

      final result = await getUserOrderRepositoriesImp.getUserOrder();

      expect(result, isA<Success<GetUserOrderEntity>>());
      expect(result, expectedResult);

      verify(getUserOrderDataSource.getUserOrder()).called(1);
    },
  );

}