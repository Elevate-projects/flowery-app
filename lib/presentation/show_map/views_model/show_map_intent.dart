import 'package:flowery_app/domain/entities/order/order_entity.dart';

sealed class ShowMapIntent {
  const ShowMapIntent();
}

final class ShowMapInitializationIntent extends ShowMapIntent {
  final OrderEntity orderData;

  ShowMapInitializationIntent({required this.orderData});
}
