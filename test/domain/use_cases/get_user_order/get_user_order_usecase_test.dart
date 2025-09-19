import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/mata_data_get_user_order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_item_entity.dart';
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
    final expectGetUserOrderEntity = GetUserOrderEntity(
      message: "ok",
      metadata: MetadataEntity(
        currentPage: 1,
        totalPages: 10,
        limit: 10,
        totalItems: 100,
      ),
      orders: [
        OrderEntity(
          id: "order123",
          user: "user123",
          orderItems: [
            OrderItemEntity(
              product: const ProductCardEntity(
                categoryId: "category123",
                title: "product title",
              ),
            )
          ]
        )
      ]
    );
    final expectGetUserOrderResult = Success(expectGetUserOrderEntity);
    provideDummy<Result<GetUserOrderEntity>>(expectGetUserOrderResult);
    when(
      mocgetUserOrder.getUserOrder(),
    ).thenAnswer((_) async => expectGetUserOrderResult);
    final result = await getUserOrderUseCase.getUserOrder();
    final successResult = result as Success<GetUserOrderEntity>;
    expect(result, isA<Success<GetUserOrderEntity>>());
    verify(mocgetUserOrder.getUserOrder()).called(1);
    expect(
      expectGetUserOrderEntity.message,
      equals(successResult.data.message),
    );
  });
}