import 'package:flowery_app/core/state_status/state_status.dart';
import 'package:flowery_app/domain/entities/arguments/occasion_arguments_entity.dart';
import 'package:flowery_app/domain/entities/home_products/occasion_products_entity.dart';
import 'package:flowery_app/presentation/home/occasions/view_model/occasion_intent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OccasionsViewModel
    extends Cubit<StateStatus<List<OccasionProductsEntity>>> {
  OccasionsViewModel() : super(const StateStatus.initial());

  void doIntent({required OccasionIntent intent}) {
    switch (intent) {
      case LoadOccasionProducts():
        _loadOccasionProducts(occasionData: intent.occasionData);
    }
  }

  void _loadOccasionProducts({
    required OccasionArgumentsEntity occasionData,
  }) async {
    final occasions = occasionData.occasions;
    final products = occasionData.listOfProducts;
    final mapped = occasions
        .map((occasion) {
          final filteredProducts = products
              .where((product) => product.occasionId == occasion.id)
              .toList();

          return OccasionProductsEntity(
            listOfProducts: filteredProducts,
            occasion: occasion,
          );
        })
        .where((entity) => entity.listOfProducts.isNotEmpty)
        .toList();

    emit(StateStatus.success(mapped));
  }
}
