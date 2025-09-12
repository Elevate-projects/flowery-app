sealed class GiftSwitchState {}
final class GiftSwitchInitial extends GiftSwitchState {
  final bool isGift;
  GiftSwitchInitial({this.isGift = false});
}