import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/core/exceptions/response_exception.dart';
import 'package:flowery_app/domain/entities/cart/delete_cart/delete_cart_item.dart';
import 'package:flowery_app/domain/use_cases/cart/delete_cart_item_use_case/delete_cart_item_use_case.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_cubit.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_intent.dart';
import 'package:flowery_app/presentation/cart/view_model/delete_cubit/delete_state.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'delete_cubit_test.mocks.dart';

@GenerateMocks([DeleteCartItemUseCase])
void main() {
  late MockDeleteCartItemUseCase mockDeleteCartItemUseCase;
  late DeleteCartCubit cubit;
  late DeleteItemsEntity fakeDeleteResult;

  setUpAll(() {
    FloweryMethodHelper.currentUserToken = "fake_token";
    fakeDeleteResult = const DeleteItemsEntity(
      message: "Item deleted successfully",
      numOfCartItems: 0,
    );

    provideDummy<Result<DeleteItemsEntity>>(Success(fakeDeleteResult));

  });

  setUp(() {
    mockDeleteCartItemUseCase = MockDeleteCartItemUseCase();
    cubit = DeleteCartCubit(mockDeleteCartItemUseCase);
  });

  group("DeleteCartCubit Tests", () {
    blocTest<DeleteCartCubit, DeleteCartState>(
      'emits loading then success when deleteCartItemUseCase returns Success',
      build: () {
        when(mockDeleteCartItemUseCase.deleteCartItem("123"))
            .thenAnswer((_) async => Success(fakeDeleteResult));
        return cubit;
      },
      act: (cubit) async =>
      await cubit.doIntent(DeleteCartItemIntent(
        productId: "123",
      )),
      expect: () => [
        isA<DeleteCartState>().having((s) => s.deleteStatus.isLoading, "isLoading", true),
        isA<DeleteCartState>()
            .having((s) => s.deleteStatus.isSuccess, "isSuccess", true)
            .having((s) => s.deleteStatus.data, "data", fakeDeleteResult),
      ],
    );

    blocTest<DeleteCartCubit, DeleteCartState>(
      'emits loading then failure when deleteCartItemUseCase returns Failure',
      build: () {
        when(mockDeleteCartItemUseCase.deleteCartItem(
            "0",
        ))
            .thenAnswer((_) async => Failure(
          responseException: const ResponseException(message: "Delete failed"),
        ));
        return cubit;
      },
      act: (cubit) async =>
      await cubit.doIntent(DeleteCartItemIntent(
        productId: "0",
      )),
      expect: () => [
        isA<DeleteCartState>().having((s) => s.deleteStatus.isLoading, "isLoading", true),
        isA<DeleteCartState>()
            .having((s) => s.deleteStatus.isFailure, "isFailure", true)
            .having((s) => s.deleteStatus.error?.message, "error message", "Delete failed"),
      ],
    );
    blocTest<DeleteCartCubit, DeleteCartState>(
      'emits failure when token is null',
      build: () {
        FloweryMethodHelper.currentUserToken = null;
        return cubit;
      },
      act: (cubit) async =>
      await cubit.doIntent(DeleteCartItemIntent(productId: "123")),
      expect: () => [],
    );

  });
}
