import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/domain/entities/get_user_order/mata_data_get_user_order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_item_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/get_user_order/get_user_order_entity.dart';
import 'package:flowery_app/domain/use_cases/get_user_order/get_user_order_usecase.dart';
import 'package:flowery_app/presentation/order_page/view_model/order_page_cubit.dart';
import 'package:flowery_app/presentation/order_page/view_model/order_page_status.dart';

import 'order_page_cubit_test.mocks.dart';
@GenerateMocks([GetUserUseCase])
void main() {
  late MockGetUserUseCase mockGetUserUseCase;
  late GetUserOrderCubit cubit;
  late GetUserOrderEntity fakeOrder;

  setUpAll(() {
    fakeOrder = GetUserOrderEntity(
      message: "success",
      metadata: MetadataEntity(
        currentPage: 1,
        totalPages: 5,
        limit: 10,
        totalItems: 50,
      ),
      orders: [
        OrderEntity(
          id: "order1",
          user: "user1",
          orderItems: [
            OrderItemEntity(
              product: const ProductCardEntity(
                categoryId: "product1",
                title: "Red Rose",
                imgCover: "image.png",
                price: 100,
                priceAfterDiscount: 90,
                quantity: 1,
              ),
            ),
          ],
        ),
      ],
    );

    provideDummy<Result<GetUserOrderEntity>>(Success(fakeOrder));
  });

  setUp(() {
    mockGetUserUseCase = MockGetUserUseCase();
    cubit = GetUserOrderCubit(mockGetUserUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  blocTest<GetUserOrderCubit, GetUserOrderState>(
    'emits [loading, success] when usecase returns Success',
    build: () {
      when(mockGetUserUseCase.getUserOrder())
          .thenAnswer((_) async => Success(fakeOrder));
      return cubit;
    },
    act: (cubit) => cubit.fetchUserOrders(),
    expect: () => [
      isA<GetUserOrderState>().having((s) => s.orderStatus.isLoading, 'isLoading', true),
      isA<GetUserOrderState>()
          .having((s) => s.orderStatus.isSuccess, 'isSuccess', true)
          .having((s) => s.orderStatus.data, 'order data', fakeOrder),
    ],
    verify: (_) {
      verify(mockGetUserUseCase.getUserOrder()).called(1);
    },
  );

  blocTest<GetUserOrderCubit, GetUserOrderState>(
    'emits [loading, failure] when usecase returns Failure',
    build: () {
      when(mockGetUserUseCase.getUserOrder()).thenAnswer(
            (_) async => Failure(
          responseException: const ResponseException(message: "Failed to fetch orders"),
        ),
      );
      return cubit;
    },
    act: (cubit) => cubit.fetchUserOrders(),
    expect: () => [
      isA<GetUserOrderState>().having((s) => s.orderStatus.isLoading, 'isLoading', true),
      isA<GetUserOrderState>()
          .having((s) => s.orderStatus.isFailure, 'isFailure', true)
          .having((s) => s.orderStatus.error?.message, 'error message', "Failed to fetch orders"),
    ],
    verify: (_) {
      verify(mockGetUserUseCase.getUserOrder()).called(1);
    },
  );
}
