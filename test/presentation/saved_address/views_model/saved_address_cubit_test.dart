import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/use_cases/address/remove_address_use_case.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_cubit.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_intent.dart';
import 'package:flowery_app/presentation/saved_address/views_model/saved_address_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'saved_address_cubit_test.mocks.dart';

@GenerateMocks([RemoveAddressUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockRemoveAddressUseCase mockRemoveAddressUseCase;
  late Result<void> expectedSuccessResult;
  late Failure<void> expectedFailureResult;
  late SavedAddressCubit cubit;

  final testAddresses = [
    AddressEntity(
      street: "123 Nile Street",
      phone: "+201234567890",
      city: "Cairo",
      lat: "30.0444",
      long: "31.2357",
      username: "ahmed_tarek",
      id: "addr_001",
    ),
    AddressEntity(
      street: "45 King Fahd Road",
      phone: "+966501234567",
      city: "Riyadh",
      lat: "24.7136",
      long: "46.6753",
      username: "sara_khaled",
      id: "addr_002",
    ),
  ];

  setUp(() {
    mockRemoveAddressUseCase = MockRemoveAddressUseCase();
    cubit = SavedAddressCubit(mockRemoveAddressUseCase);
    FloweryMethodHelper.userData = null;
  });

  group("SavedAddressCubit test", () {
    blocTest<SavedAddressCubit, SavedAddressState>(
      "emits state with addresses when SavedAddressInitializationIntent is called",
      build: () => cubit,
      act: (cubit) async => await cubit.doIntent(
        intent: SavedAddressInitializationIntent(addresses: testAddresses),
      ),
      expect: () => [
        isA<SavedAddressState>().having(
          (s) => s.addresses,
          "addresses",
          testAddresses,
        ),
      ],
    );

    blocTest<SavedAddressCubit, SavedAddressState>(
      "emits [Loading, Success] when removeAddress succeeds",
      build: () {
        FloweryMethodHelper.userData?.addresses = testAddresses;
        expectedSuccessResult = Success<void>(null);
        provideDummy<Result<void>>(expectedSuccessResult);
        when(
          mockRemoveAddressUseCase.invoke(addressId: anyNamed("addressId")),
        ).thenAnswer((_) async => expectedSuccessResult);

        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: RemoveAddressIntent(addressId: "addr_001"),
      ),
      expect: () => [
        isA<SavedAddressState>().having(
          (s) => s.removeAddressStatus.isLoading,
          "Is Loading State",
          true,
        ),
        isA<SavedAddressState>().having(
          (s) => s.removeAddressStatus.isSuccess,
          "Is Success State",
          true,
        ),
      ],
      verify: (_) {
        verify(
          mockRemoveAddressUseCase.invoke(addressId: "addr_001"),
        ).called(1);
      },
    );

    blocTest<SavedAddressCubit, SavedAddressState>(
      "emits [Loading, Failure] when removeAddress fails",
      build: () {
        expectedFailureResult = Failure<void>(
          responseException: const ResponseException(
            message: "Failed to remove address",
          ),
        );
        provideDummy<Result<void>>(expectedFailureResult);
        when(
          mockRemoveAddressUseCase.invoke(addressId: anyNamed("addressId")),
        ).thenAnswer((_) async => expectedFailureResult);
        return cubit;
      },
      act: (cubit) async => await cubit.doIntent(
        intent: RemoveAddressIntent(addressId: "addr_999"),
      ),
      expect: () => [
        isA<SavedAddressState>().having(
          (s) => s.removeAddressStatus.isLoading,
          "Is Loading State",
          true,
        ),
        isA<SavedAddressState>()
            .having(
              (s) => s.removeAddressStatus.isFailure,
              "Is Failure State",
              true,
            )
            .having(
              (s) => s.removeAddressStatus.error?.message,
              "Failure Message",
              "Failed to remove address",
            ),
      ],
      verify: (_) {
        verify(
          mockRemoveAddressUseCase.invoke(addressId: "addr_999"),
        ).called(1);
      },
    );
  });
}
