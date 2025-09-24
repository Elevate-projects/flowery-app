import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_entity/order_entity.dart';
import 'package:flowery_app/domain/entities/get_user_order/order_item_entity/order_item_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/use_cases/get_user_order/get_user_order_usecase.dart';
import 'package:flowery_app/presentation/order_page/view_model/order_page_cubit.dart';
import 'package:flowery_app/presentation/order_page/view_model/order_page_status.dart';

import 'order_page_cubit_test.mocks.dart';
@GenerateMocks([GetUserUseCase])
void main() {
  late MockGetUserUseCase mockGetUserUseCase;
  late GetUserOrderCubit cubit;
  late OrderEntity orderEntity;
  setUpAll(() {
    orderEntity = OrderEntity(
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
    provideDummy<Result<List<OrderEntity>>>(Success([orderEntity]));
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
      when(mockGetUserUseCase.getUserOrder()).thenAnswer(
            (_) async => Success([orderEntity]),
      );
      return cubit;
    },
    act: (cubit) => cubit.fetchUserOrders(),
    expect: () => [
      isA<GetUserOrderState>().having((s) => s.orderStatus.isLoading, 'isLoading', true),
      isA<GetUserOrderState>()
          .having((s) => s.orderStatus.isSuccess, 'isSuccess', true)
          .having((s) => s.orderStatus.data, 'order data', [orderEntity]),
    ],
    verify: (_) {
      verify(mockGetUserUseCase.getUserOrder()).called(1);
      verifyNoMoreInteractions(mockGetUserUseCase);
      expect(cubit.state.orderStatus.isSuccess, true);
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
