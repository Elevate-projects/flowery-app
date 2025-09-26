import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/arguments/occasion_arguments_entity.dart';
import 'package:flowery_app/domain/entities/home_products/occasion_products_entity.dart';
import 'package:flowery_app/presentation/home/occasions/view_model/occasion_intent.dart';
import 'package:flowery_app/presentation/home/occasions/view_model/occasion_view_model.dart';

void main() {
  group('OccasionsViewModel Tests', () {
    late OccasionsViewModel viewModel;

    setUp(() {
      viewModel = OccasionsViewModel();
    });

    test('initial state should be StateStatus.initial()', () {
      expect(
        viewModel.state,
        const StateStatus<List<OccasionProductsEntity>>.initial(),
      );
    });

    blocTest<OccasionsViewModel, StateStatus<List<OccasionProductsEntity>>>(
      'should emit [Success] with mapped products when LoadOccasionProducts is triggered',
      build: () => viewModel,
      act: (cubit) {
        final occasion = const OccasionEntity(id: "1", name: "Birthday");
        final product1 = const ProductCardEntity(
          productId: "101",
          occasionId: "1",
          title: "Cake",
          price: 100,
        );
        final product2 = const ProductCardEntity(
          productId: "102",
          occasionId: "2",
          title: "Flowers",
          price: 50,
        );

        final arguments = OccasionArgumentsEntity(
          occasions: [occasion],
          listOfProducts: [product1, product2],
        );

        cubit.doIntent(intent: LoadOccasionProducts(occasionData: arguments));
      },
      expect: () => [
        isA<StateStatus<List<OccasionProductsEntity>>>()
            .having((s) => s.status, 'status', Status.success)
            .having((s) => s.data?.length, 'data length', 1)
            .having(
              (s) => s.data?.first.listOfProducts.first.title,
              'first product title',
              'Cake',
            ),
      ],
    );
  });
}
