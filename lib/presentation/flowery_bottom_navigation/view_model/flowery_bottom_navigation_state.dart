import 'package:equatable/equatable.dart';

class FloweryBottomNavigationState extends Equatable {
  final int currentIndex;
  const FloweryBottomNavigationState({this.currentIndex = 0});
  FloweryBottomNavigationState copyWith({int? currentIndex}) {
    return FloweryBottomNavigationState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [currentIndex];
}
