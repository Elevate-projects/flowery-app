import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flowery_app/domain/use_cases/profile/get_user_profile_data_use_case.dart';
import 'package:flowery_app/presentation/checkout/views_model/address_cubit/address_cubit.dart';
import 'package:flowery_app/presentation/checkout/views_model/address_cubit/address_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../profile/views_model/profile_cubit_test.mocks.dart';

@GenerateMocks([GetUserProfileDataUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockGetUserProfileDataUseCase mockGetUserProfileDataUseCase =
      MockGetUserProfileDataUseCase();

  provideDummy<Result<UserDataEntity?>>(Success(null));
  when(
    mockGetUserProfileDataUseCase.invoke(),
  ).thenAnswer((_) async => Success(null));

  blocTest<AddressCubit, AddressState>(
    'TODO: Implement tests for address_cubit.dart',
    build: () => AddressCubit(mockGetUserProfileDataUseCase),
    act: (cubit) => cubit.selectAddress(0),
    expect: () => [
      isA<ChangeAddressIndexState>().having(
        (state) => state.index,
        "Is ChangeAddressIndexState with value 0",
        equals(0),
      ),
      isA<FetchAddressSuccessState>(),
    ],
  );
  blocTest<AddressCubit, AddressState>(
    'TODO: Implement tests for address_cubit.dart',
    build: () => AddressCubit(mockGetUserProfileDataUseCase),
    act: (cubit) => cubit.selectAddress(1),
    expect: () => [
      isA<ChangeAddressIndexState>().having(
        (state) => state.index,
        "Is ChangeAddressIndexState with value 1",
        equals(1),
      ),
      isA<FetchAddressSuccessState>(),
    ],
  );
}
