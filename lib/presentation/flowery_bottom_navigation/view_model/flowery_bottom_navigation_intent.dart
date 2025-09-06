sealed class FloweryBottomNavigationIntent {}

class ChangeIndexIntent extends FloweryBottomNavigationIntent {
  ChangeIndexIntent({required this.index});
  final int index;
}
