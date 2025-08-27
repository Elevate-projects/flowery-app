import 'package:flutter_bloc/flutter_bloc.dart';

 import '../../../../core/state_status/state_status.dart';
import '../../../../domain/entities/occasions/get_occasions/product_card_entity.dart';
import '../../../../domain/entities/product_card/product_card_entity.dart';
 import 'occasion_intent.dart';

class OccasionsViewModel extends Cubit<StateStatus<List<ProductCardEntity>>> {
   OccasionsViewModel( ):super(const StateStatus.initial());


   void doIntent(OccasionIntent intent) {
     if (intent is LoadOccasionProducts) {
       _loadOccasionProducts(intent.occasionName);
     }
   }
   void _loadOccasionProducts(String occasionName ) async {
     emit(const StateStatus.loading());

     await Future.delayed(const Duration(seconds: 1));


     emit(StateStatus.success(fakeProducts));
   }
}




