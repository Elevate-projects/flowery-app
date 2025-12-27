import 'package:flowery_app/domain/entities/order/order_entity.dart';
import 'package:latlong2/latlong.dart';

sealed class ShowMapIntent {
  const ShowMapIntent();
}

final class ShowMapInitializationIntent extends ShowMapIntent {
  final OrderEntity orderData;

  const ShowMapInitializationIntent({required this.orderData});
}

final class UpdateRouteIntent extends ShowMapIntent {
  final LatLng driverLocation;

  const UpdateRouteIntent({required this.driverLocation});
}
