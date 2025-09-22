import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_item_entity/order_item_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/repositories/get_user_order/get_user_order_repositories.dart';
import 'package:flowery_app/domain/use_cases/get_user_order/get_user_order_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_user_order_usecase_test.mocks.dart';
@GenerateMocks([GetUserOrderRepositories])
void main() {
  test('when call GetLoggedUserCartUseCase it should be called successfully should return GetUserOrderEntity', () async {
    final mocgetUserOrder = MockGetUserOrderRepositories();
    final getUserOrderUseCase = GetUserUseCase(
      mocgetUserOrder,
    );
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
    when(mocgetUserOrder.getUserOrder())
        .thenAnswer((_) async => Success([mockorderentity]));
    final result = await getUserOrderUseCase.getUserOrder();
    verify(mocgetUserOrder.getUserOrder()).called(1);
    expect(result, isA<Success<List<OrderEntity>>>());
    final successResult = result as Success<List<OrderEntity>>;
    expect(successResult.data.first.id, mockorderentity.id);
    expect(result, isA<Success<List<OrderEntity>>>());
  });
}