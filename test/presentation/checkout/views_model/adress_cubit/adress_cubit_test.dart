import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/presentation/checkout/views_model/adress_cubit/adress_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Tinitial state should be null', () {
    final cubit = AddressCubit();
    expect(cubit.state, null);
  });
  blocTest<AddressCubit, int?>('TODO: Implement tests for adress_cubit.dart',
      build: () => AddressCubit(),
      act: (cubit) => cubit.selectAddress(0),
      expect: () => [0]
  );
  blocTest<AddressCubit, int?>('TODO: Implement tests for adress_cubit.dart',
      build: () => AddressCubit(),
      act: (cubit) => cubit.selectAddress(1),
      expect: () => [1]
  );
}