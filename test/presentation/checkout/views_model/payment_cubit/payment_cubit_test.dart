import 'package:flowery_app/domain/entities/payment/enum/payment_method.dart';
import 'package:flowery_app/presentation/checkout/views_model/payment_cubit/payment_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
void main() {
  group('PaymentCubit', () {
    test('initial state should be empty string', () {
      final cubit = PaymentCubit();
      expect(cubit.state, null);
    });

    blocTest<PaymentCubit, PaymentMethod?>(
      'emits [credit_card] when selectMethod("credit_card") is called',
      build: () => PaymentCubit(),
      act: (cubit) => cubit.selectMethod(PaymentMethod.credit),
      expect: () => [PaymentMethod.credit],
    );

    blocTest<PaymentCubit, PaymentMethod?>(
      'emits [cash] when selectMethod("cash") is called',
      build: () => PaymentCubit(),
      act: (cubit) => cubit.selectMethod(PaymentMethod.cash),
      expect: () => [PaymentMethod.cash],
    );

    blocTest<PaymentCubit, PaymentMethod?>(
      'emits [PaymentMethod.credit, PaymentMethod.cash] when selectMethod is called twice',
      build: () => PaymentCubit(),
      act: (cubit) {
        cubit.selectMethod(PaymentMethod.credit);
        cubit.selectMethod(PaymentMethod.cash);
      },
      expect: () => [PaymentMethod.credit, PaymentMethod.cash],
    );
  });
}
