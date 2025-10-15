import 'package:latlong2/latlong.dart';

sealed class ShowMapIntent {
  const ShowMapIntent();
}

final class ShowMapInitializationIntent extends ShowMapIntent {
  LatLng userLocation;
  LatLng storeLocation;

  ShowMapInitializationIntent({
    required this.userLocation,
    required this.storeLocation,
  });
}
