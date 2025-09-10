import 'package:flowery_app/domain/entities/requests/add_to_cart_request/add_to_cart_request_entity.dart';

sealed class AddProductToCartIntent {}

class AddToCartIntent extends AddProductToCartIntent {
  final AddToCartRequestEntity request;
  AddToCartIntent({required this.request});
}

class ChangeSelectedProductId extends AddProductToCartIntent {
  final String productId;
  ChangeSelectedProductId({required this.productId});
}
