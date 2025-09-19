import 'package:flowery_app/presentation/checkout/views_model/checkout_cubit/checkout_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/presentation/checkout/views_model/checkout_cubit/gift_state.dart';
void main() {
  group('GiftSwitchCubit', () {
    test('initial state should be GiftSwitchInitial with isGift = false', () {
      final cubit = GiftSwitchCubit();
      expect(cubit.state, isA<GiftSwitchInitial>());
      expect((cubit.state as GiftSwitchInitial).isGift, false);
    });

    blocTest<GiftSwitchCubit, GiftSwitchState>(
      'emits GiftSwitchInitial(isGift: true) when toggleGiftSwitch(true) is called',
      build: () => GiftSwitchCubit(),
      act: (cubit) => cubit.toggleGiftSwitch(true),
      expect: () => [isA<GiftSwitchInitial>().having((s) => s.isGift, 'isGift', true)],
    );

    blocTest<GiftSwitchCubit, GiftSwitchState>(
      'emits GiftSwitchInitial(isGift: false) when toggleGiftSwitch(false) is called',
      build: () => GiftSwitchCubit(),
      act: (cubit) => cubit.toggleGiftSwitch(false),
      expect: () => [isA<GiftSwitchInitial>().having((s) => s.isGift, 'isGift', false)],
    );

    blocTest<GiftSwitchCubit, GiftSwitchState>(
      'emits [true, false] when toggleGiftSwitch(true) then toggleGiftSwitch(false) is called',
      build: () => GiftSwitchCubit(),
      act: (cubit) {
        cubit.toggleGiftSwitch(true);
        cubit.toggleGiftSwitch(false);
      },
      expect: () => [
        isA<GiftSwitchInitial>().having((s) => s.isGift, 'isGift', true),
        isA<GiftSwitchInitial>().having((s) => s.isGift, 'isGift', false),
      ],
    );
  });
}
