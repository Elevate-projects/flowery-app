sealed class BottomNavIntent{}
class ChangeIntent extends BottomNavIntent{
  final int index;
  ChangeIntent(this.index);
}