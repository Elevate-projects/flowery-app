sealed class TrackOrderProgressIntent {
  const TrackOrderProgressIntent();
}

final class FetchTrackedOrderDataIntent extends TrackOrderProgressIntent {
  const FetchTrackedOrderDataIntent({required this.orderId});
  final String orderId;
}

final class OpenWhatsAppIntent extends TrackOrderProgressIntent {
  const OpenWhatsAppIntent();
}

final class OpenPhoneIntent extends TrackOrderProgressIntent {
  const OpenPhoneIntent();
}

final class OrderReceivedIntent extends TrackOrderProgressIntent {
  const OrderReceivedIntent();
}

final class ShowMapIntent extends TrackOrderProgressIntent {
  const ShowMapIntent();
}
