import 'package:flowery_app/api/client/api_result.dart';
import 'package:flowery_app/domain/entities/arguments/occasion_arguments_entity.dart';
import 'package:flowery_app/domain/entities/home_products/products_response_entity.dart';
import 'package:flowery_app/domain/use_cases/home_products/home_products_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/presentation/home/occasions/view_model/occasion_intent.dart';

@injectable
class OccasionsViewModel
    extends Cubit<StateStatus<List<OccasionArgumentsEntity>>> {
  OccasionsViewModel(this._homeProductsUseCase)
    : super(const StateStatus.initial());
  final HomeProductsUseCase _homeProductsUseCase;

  void doIntent(OccasionIntent intent) {
    if (intent is LoadOccasionProducts) {
      _loadOccasionProducts(intent.occasionId);
    }
  }

  void _loadOccasionProducts(String occasionId) async {
    emit(const StateStatus.loading());

    final result = await _homeProductsUseCase.invoke();
    switch (result) {
      case Success<ProductsResponseEntity>():
        final occasions = result.data.occasions ?? [];
        final products = result.data.products ?? [];
        final mapped = occasions
            .map((occasion) {
              final filteredProducts = products
                  .where((product) => product.occasionId == occasion.id)
                  .toList();

              return OccasionArgumentsEntity(
                listOfProducts: filteredProducts,
                occasion: occasion,
              );
            })
            .where((entity) => entity.listOfProducts.isNotEmpty)
            .toList();

        emit(StateStatus.success(mapped));
      case Failure<ProductsResponseEntity>():
        emit(StateStatus.failure(result.responseException));
    }
  }
}
