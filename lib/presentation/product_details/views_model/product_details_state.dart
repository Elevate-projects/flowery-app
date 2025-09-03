import 'package:equatable/equatable.dart';

class ProductDetailsState extends Equatable {
  final List<String>? productImages;
  final bool? isInStock;
  const ProductDetailsState({
    this.productImages = const [],
    this.isInStock = false,
  });

  ProductDetailsState copyWith({List<String>? productImages, bool? isInStock}) {
    return ProductDetailsState(
      productImages: productImages ?? this.productImages,
      isInStock: isInStock ?? this.isInStock,
    );
  }

  @override
  List<Object?> get props => [productImages, isInStock];
}
