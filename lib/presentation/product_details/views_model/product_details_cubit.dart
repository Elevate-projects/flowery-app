import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_intent.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(const ProductDetailsState());
  late final PageController imagesPageController;

  Future<void> doIntent({required ProductDetailsIntent intent}) async {
    switch (intent) {
      case InitializeProductDetailsIntent():
        _onInit(productCardData: intent.productCardData);
        break;
      case NavigateToSelectedImageIntent():
        _navigateToSelectedImage(selectedImageIndex: intent.selectedImageIndex);
        break;
    }
  }

  void _onInit({required ProductCardEntity productCardData}) {
    final images = _getProductImages(productCardData: productCardData);
    final bool isInStock = _checkProductAvailability(
      quantity: productCardData.quantity,
    );
    imagesPageController = PageController();
    emit(state.copyWith(productImages: images, isInStock: isInStock));
  }

  List<String> _getProductImages({required ProductCardEntity productCardData}) {
    if (productCardData.images?.isNotEmpty ?? false) {
      return productCardData.images!;
    } else {
      return [productCardData.imgCover ?? ''];
    }
  }

  void _navigateToSelectedImage({required int selectedImageIndex}) {
    imagesPageController.animateToPage(
      selectedImageIndex,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  bool _checkProductAvailability({required num? quantity}) {
    if (quantity == null || quantity < 1) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<void> close() {
    imagesPageController.dispose();
    return super.close();
  }
}
