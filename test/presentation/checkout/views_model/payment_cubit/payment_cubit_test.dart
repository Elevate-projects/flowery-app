import 'package:flowery_app/presentation/checkout/views_model/payment_cubit/payment_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
void main() {
  group('PaymentCubit', () {
    test('initial state should be empty string', () {
      final cubit = PaymentCubit();
      expect(cubit.state, "");
    });

    blocTest<PaymentCubit, String>(
      'emits [credit_card] when selectMethod("credit_card") is called',
      build: () => PaymentCubit(),
      act: (cubit) => cubit.selectMethod("credit_card"),
      expect: () => ["credit_card"],
    );

    blocTest<PaymentCubit, String>(
      'emits [paypal] when selectMethod("paypal") is called',
      build: () => PaymentCubit(),
      act: (cubit) => cubit.selectMethod("paypal"),
      expect: () => ["paypal"],
    );

    blocTest<PaymentCubit, String>(
      'emits [visa, master] when selectMethod is called twice',
      build: () => PaymentCubit(),
      act: (cubit) {
        cubit.selectMethod("visa");
        cubit.selectMethod("master");
      },
      expect: () => ["visa", "master"],
    );
  });
}
