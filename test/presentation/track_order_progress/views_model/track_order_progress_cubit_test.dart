import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/cache/shared_preferences_helper.dart';
import 'package:flowery_app/core/constants/app_text.dart';
import 'package:flowery_app/core/constants/const_keys.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:flowery_app/domain/entities/order_item/order_item_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/domain/entities/shipping_address/shipping_address_entity.dart';
import 'package:flowery_app/domain/entities/store/store_entity.dart';
import 'package:flowery_app/domain/entities/user/user_entity.dart';
import 'package:flowery_app/domain/use_cases/get_tracked_order/get_tracked_order_use_case.dart';
import 'package:flowery_app/domain/use_cases/order_received/order_received_use_case.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_cubit.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_intent.dart';
import 'package:flowery_app/presentation/track_order_progress/views_model/track_order_progress_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../fake_url_launcher.dart';
import 'track_order_progress_cubit_test.mocks.dart';

@GenerateMocks([
  GetTrackedOrderUseCase,
  OrderReceivedUseCase,
  SharedPreferencesHelper,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late final MockGetTrackedOrderUseCase mockGetTrackedOrderUseCase;
  late final MockOrderReceivedUseCase mockOrderReceivedUseCase;
  late final MockSharedPreferencesHelper mockSharedPreferencesHelper;
  late TrackOrderProgressCubit cubit;
  late final OrderEntity expectedCurrentOrder;
  late FakeUrlLauncher fakeLauncher;

  setUpAll(() {
    mockGetTrackedOrderUseCase = MockGetTrackedOrderUseCase();
    mockSharedPreferencesHelper = MockSharedPreferencesHelper();
    mockOrderReceivedUseCase = MockOrderReceivedUseCase();
    expectedCurrentOrder = const OrderEntity(
      id: "order_2",
      user: UserEntity(
        id: "user_2",
        firstName: "Mona",
        lastName: "Ali",
        email: "mona@example.com",
      ),
      orderItems: [
        OrderItemEntity(
          id: "item_2",
          product: ProductCardEntity(
            productId: "prod_2",
            description: "A colorful mix of tulips",
            price: 350,
          ),
          price: 350,
          quantity: 2,
        ),
      ],
      totalPrice: 700,
      shippingAddress: ShippingAddressEntity(city: "Giza"),
      paymentType: "Credit Card",
      isPaid: true,
      isDelivered: true,
      state: "inProgress",
      orderNumber: "ORD-002",
      store: StoreEntity(name: "Flower Hub", address: "Mall of Egypt"),
    );
    when(
      mockSharedPreferencesHelper.getBool(key: ConstKeys.isArLanguage),
    ).thenAnswer((_) => false);
  });
  setUp(() {
    fakeLauncher = FakeUrlLauncher();
    UrlLauncherPlatform.instance = fakeLauncher;
    cubit = TrackOrderProgressCubit(
      mockGetTrackedOrderUseCase,
      mockOrderReceivedUseCase,
      mockSharedPreferencesHelper,
    );
  });

  group("TrackOrderProgress cubit test", () {
    blocTest<TrackOrderProgressCubit, TrackOrderProgressState>(
      'emits [Loading, Success] when FetchTrackedOrderDataIntent succeeds',
      build: () {
        final expectedSuccessResult = Success<OrderEntity>(
          expectedCurrentOrder,
        );
        provideDummy<Result<OrderEntity>>(expectedSuccessResult);
        when(
          mockGetTrackedOrderUseCase.invoke(orderId: anyNamed("orderId")),
        ).thenAnswer((_) => Stream.value(expectedSuccessResult));
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: FetchTrackedOrderDataIntent(
          orderId: expectedCurrentOrder.id ?? "",
        ),
      ),
      expect: () => [
        isA<TrackOrderProgressState>().having(
          (state) => state.currentOrderStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<TrackOrderProgressState>()
            .having(
              (state) => state.currentOrderStatus.isSuccess,
              "Is Success State",
              equals(true),
            )
            .having(
              (state) => state.currentOrderStatus.data != null,
              "Is Success Data equals expected Data",
              equals(true),
            )
            .having(
              (state) => state.currentOrderStatus.data?.id,
              "Is Success Data equals expected Data",
              equals(expectedCurrentOrder.id),
            )
            .having(
              (state) => state.currentOrderStatus.data?.state,
              "Is Success Data equals expected Data",
              equals(expectedCurrentOrder.state),
            )
            .having(
              (state) => state.currentOrderStatus.data?.paymentType,
              "Is Success Data equals expected Data",
              equals(expectedCurrentOrder.paymentType),
            ),
      ],
      verify: (_) {
        verify(
          mockGetTrackedOrderUseCase.invoke(orderId: anyNamed("orderId")),
        ).called(1);
      },
    );

    blocTest<TrackOrderProgressCubit, TrackOrderProgressState>(
      "emits [Loading, Failure] when FetchTrackedOrderDataIntent is Called",
      build: () {
        final expectedFailureResult = Failure<OrderEntity>(
          responseException: const ResponseException(
            message: "failed to load order data",
          ),
        );
        provideDummy<Result<OrderEntity>>(expectedFailureResult);
        when(
          mockGetTrackedOrderUseCase.invoke(orderId: anyNamed("orderId")),
        ).thenAnswer((_) => Stream.value(expectedFailureResult));
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: FetchTrackedOrderDataIntent(
          orderId: expectedCurrentOrder.id ?? "",
        ),
      ),
      expect: () => [
        isA<TrackOrderProgressState>().having(
          (state) => state.currentOrderStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<TrackOrderProgressState>()
            .having(
              (state) => state.currentOrderStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.currentOrderStatus.error?.message,
              'responseException.message',
              equals("failed to load order data"),
            ),

        isA<TrackOrderProgressState>().having(
          (state) => state.currentOrderStatus.isInitial,
          "Is Initial State Again",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockGetTrackedOrderUseCase.invoke(orderId: anyNamed("orderId")),
        ).called(1);
      },
    );

    blocTest<TrackOrderProgressCubit, TrackOrderProgressState>(
      'emits [Loading, Success] when OrderReceivedIntent succeeds',
      build: () {
        final expectedSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedSuccessResult);
        when(
          mockOrderReceivedUseCase.invoke(orderId: anyNamed("orderId")),
        ).thenAnswer((_) async => expectedSuccessResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const OrderReceivedIntent()),
      expect: () => [
        isA<TrackOrderProgressState>().having(
          (state) => state.receivedOrderStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<TrackOrderProgressState>().having(
          (state) => state.receivedOrderStatus.isSuccess,
          "Is Success State",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockOrderReceivedUseCase.invoke(orderId: anyNamed("orderId")),
        ).called(1);
      },
    );

    blocTest<TrackOrderProgressCubit, TrackOrderProgressState>(
      "emits [Loading, Failure] when OrderReceivedIntent is Called",
      build: () {
        final expectedFailureResult = Failure<void>(
          responseException: const ResponseException(
            message: "failed to update state",
          ),
        );
        provideDummy<Result<void>>(expectedFailureResult);
        when(
          mockOrderReceivedUseCase.invoke(orderId: anyNamed("orderId")),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const OrderReceivedIntent()),
      expect: () => [
        isA<TrackOrderProgressState>().having(
          (state) => state.receivedOrderStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<TrackOrderProgressState>()
            .having(
              (state) => state.receivedOrderStatus.isFailure,
              "Is Failure State",
              equals(true),
            )
            .having(
              (state) => state.receivedOrderStatus.error?.message,
              'responseException.message',
              equals("failed to update state"),
            ),

        isA<TrackOrderProgressState>().having(
          (state) => state.receivedOrderStatus.isInitial,
          "Is Initial State Again",
          equals(true),
        ),
      ],
      verify: (_) {
        verify(
          mockOrderReceivedUseCase.invoke(orderId: anyNamed("orderId")),
        ).called(1);
      },
    );

    blocTest<TrackOrderProgressCubit, TrackOrderProgressState>(
      'emits [Loading, Success] when OpenWhatsAppIntent succeeds',
      build: () {
        fakeLauncher.canLaunchResult = true;
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const OpenWhatsAppIntent()),
      expect: () => [
        isA<TrackOrderProgressState>().having(
          (state) =>
              state.openWhatsappStatus.isLoading && state.isOpeningWhatsapp,
          "Is Loading State",
          equals(true),
        ),
        isA<TrackOrderProgressState>().having(
          (state) =>
              state.openWhatsappStatus.isSuccess && !state.isOpeningWhatsapp,
          "Is Success State",
          equals(true),
        ),
      ],
    );

    blocTest<TrackOrderProgressCubit, TrackOrderProgressState>(
      'emits [Loading, Failure, Initial] when WhatsApp launch fails',
      build: () {
        fakeLauncher.shouldThrow = true;
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const OpenWhatsAppIntent()),
      expect: () => [
        isA<TrackOrderProgressState>().having(
          (state) => state.openWhatsappStatus.isLoading,
          "Is Loading State",
          equals(true),
        ),
        isA<TrackOrderProgressState>().having(
          (state) => state.openWhatsappStatus.isFailure,
          "Is Failure State",
          equals(true),
        ),
        isA<TrackOrderProgressState>().having(
          (state) => state.openWhatsappStatus.isInitial,
          "Is Initial State Again",
          equals(true),
        ),
      ],
    );

    blocTest<TrackOrderProgressCubit, TrackOrderProgressState>(
      'emits [Loading, Success] when phone dialer opens successfully',
      build: () {
        fakeLauncher.canLaunchResult = true;
        fakeLauncher.shouldThrow = false;
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const OpenPhoneIntent()),
      expect: () => [
        isA<TrackOrderProgressState>().having(
          (state) => state.openPhoneStatus.isLoading && state.isOpeningPhone,
          'Loading state emitted',
          true,
        ),
        isA<TrackOrderProgressState>().having(
          (state) => state.openPhoneStatus.isSuccess && !state.isOpeningPhone,
          'Success state emitted',
          true,
        ),
      ],
    );

    blocTest<TrackOrderProgressCubit, TrackOrderProgressState>(
      'emits [Loading, Failure, Initial] when launch throws an exception',
      build: () {
        fakeLauncher.shouldThrow = true;
        return cubit;
      },
      act: (cubit) async =>
          await cubit.doIntent(intent: const OpenPhoneIntent()),
      expect: () => [
        isA<TrackOrderProgressState>().having(
          (state) => state.openPhoneStatus.isLoading && state.isOpeningPhone,
          'Loading state emitted',
          true,
        ),
        isA<TrackOrderProgressState>().having(
          (state) =>
              state.openPhoneStatus.isFailure &&
              state.openPhoneStatus.error?.message ==
                  AppText.openPhoneFailureMessage,
          'Failure state emitted with correct message',
          true,
        ),
        isA<TrackOrderProgressState>().having(
          (state) => state.openPhoneStatus.isInitial && !state.isOpeningPhone,
          'Reset to initial state after failure',
          true,
        ),
      ],
    );
  });
}
