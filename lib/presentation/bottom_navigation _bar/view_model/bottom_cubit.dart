import 'package:flutter/material.dart';
import '../../pages/categories_page.dart';
import 'bottom_intent.dart';
import 'bottom_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class BottomCubit extends Cubit<BottomState> {
  BottomCubit() : super(const BottomState());
  List<Widget> pages = [
    const Center(child: Text('Home Page')),
    CategoriesPage(),
    const Center(child: Text('Cart Page')),
    const Center(child: Text('Profile Page')),
  ];
  void doIntent(BottomNavIntent intent){
    switch(intent){
      case ChangeIntent(:final index):
        emit(state.copyWith(currentIndex: index));
        break;
    }
  }
}