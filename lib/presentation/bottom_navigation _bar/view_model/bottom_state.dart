class BottomState{
  final int currentIndex;
    const BottomState({this.currentIndex= 0});
    BottomState copyWith({int? currentIndex}) {
      return BottomState(currentIndex: currentIndex ?? this.currentIndex);
    }
}