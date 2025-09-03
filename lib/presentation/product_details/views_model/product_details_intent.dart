import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

sealed class ProductDetailsIntent {}

class InitializeProductDetailsIntent extends ProductDetailsIntent {
  final ProductCardEntity productCardData;

  InitializeProductDetailsIntent({required this.productCardData});
}

class NavigateToSelectedImageIntent extends ProductDetailsIntent {
  final int selectedImageIndex;

  NavigateToSelectedImageIntent({required this.selectedImageIndex});
}
