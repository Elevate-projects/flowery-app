import 'package:flowery_app/presentation/categories/views/categories_view.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/view_model/flowery_bottom_navigation_intent.dart';
import 'package:flowery_app/presentation/flowery_bottom_navigation/view_model/flowery_bottom_navigation_state.dart';
import 'package:flowery_app/presentation/home/home_screen/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloweryBottomNavigationCubit extends Cubit<FloweryBottomNavigationState> {
  FloweryBottomNavigationCubit() : super(const FloweryBottomNavigationState());
  final List<Widget> pages = [
    const HomeView(),
    const CategoriesView(),
    const Center(child: Text('Cart Page')),
    const Center(child: Text('Profile Page')),
  ];

  void doIntent({required FloweryBottomNavigationIntent intent}) {
    switch (intent) {
      case ChangeIndexIntent():
        _changeTapIndex(index: intent.index);
    }
  }

  void _changeTapIndex({required int index}) {
    emit(state.copyWith(currentIndex: index));
  }
}
