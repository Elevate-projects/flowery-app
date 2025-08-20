import 'bottom_intent.dart';
import 'bottom_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BottomCubit extends Cubit<BottomState> {
   BottomCubit() : super(BottomState());
   void onIntent(BottomNavIntent intent){
     if(intent is ChangeIntent){
       emit(state.copyWith(currentIndex: intent.index));
     }
   }
}