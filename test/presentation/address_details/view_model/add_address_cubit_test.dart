import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/address/add_address_request_entity.dart';
import 'package:flowery_app/domain/entities/address/address_entity.dart';
import 'package:flowery_app/domain/use_cases/address/add_address_use_case.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_cubit.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_intent.dart';
import 'package:flowery_app/presentation/address_details/view_model/add_address_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_address_cubit_test.mocks.dart';

@GenerateMocks([GetAddAddressUseCase])
void main() {
  late MockGetAddAddressUseCase getAddAddressUseCase;

  final addAddressRequest = AddAddressRequestEntity(
    city: 'Cairo',
    street: '123 Main St',
    username: 'John Doe',
    phone: '1234567890',
    lat: '30.0444',
    long: '31.2357',
  );

  final List<AddressEntity> expectedEntities = [
    AddressEntity(
      username: 'John Doe',
      phone: '1234567890',
      city: 'Cairo',
      street: '123 Main St',
      lat: '30.0444',
      long: '31.2357',
      id: 'addr_123',
    ),
  ];

  final expectedResult = Success<List<AddressEntity>?>(expectedEntities);
  setUp(() {
    getAddAddressUseCase = MockGetAddAddressUseCase();
    provideDummy<Result<List<AddressEntity>?>>(expectedResult);

    when(
      getAddAddressUseCase.execute(addAddressRequest),
    ).thenAnswer((_) async => expectedResult);
  });
  blocTest<AddAddressCubit, AddAddressState>(
    'should emit [loading, success] when add address is successful',
    build: () => AddAddressCubit(getAddAddressUseCase),
    act: (cubit) =>
        cubit.doIntent(OnAddAddressInitializationIntent(addAddressRequest)),
    expect: () => [
      const AddAddressState(addAddressStatus: StateStatus.loading()),
      const AddAddressState(addAddressStatus: StateStatus.success(null)),
      const AddAddressState(addAddressStatus: StateStatus.initial()),
    ],
  );
}
