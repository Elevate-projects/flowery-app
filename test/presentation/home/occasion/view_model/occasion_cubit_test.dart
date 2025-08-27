import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/occasions/get_occasions/product_card_entity.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/home/occasion/view_model/occasion_cubit.dart';
import 'package:flowery_app/presentation/home/occasion/view_model/occasion_intent.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('OccasionsViewModel Test', () {
    blocTest<OccasionsViewModel, StateStatus<List<ProductCardEntity>>>(
      'emits [loading, success] when LoadOccasionProducts is called',
      build: () => OccasionsViewModel(),
      act: (viewModel) => viewModel.doIntent(LoadOccasionProducts("Wedding")),
       expect: () => [
        const StateStatus<List<ProductCardEntity>>.loading(),
        StateStatus<List<ProductCardEntity>>.success(fakeProducts),
      ],
    );
  });
}