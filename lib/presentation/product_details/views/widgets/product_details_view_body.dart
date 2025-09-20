import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/product_details/views/widgets/product_details_add_to_cart_button.dart';
import 'package:flowery_app/presentation/product_details/views/widgets/product_details_section.dart';
import 'package:flowery_app/presentation/product_details/views/widgets/product_images_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsViewBody extends StatelessWidget {
  const ProductDetailsViewBody({super.key, required this.productCardData});
  final ProductCardEntity productCardData;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ProductImagesPreview(),
          const RSizedBox(height: 16),
          ProductDetailsSection(productCardData: productCardData),
          const RSizedBox(height: 24),
          ProductDetailsAddToCartButton(
            productId: productCardData.productId ?? "",
          ),
          const RSizedBox(height: 31),
        ],
      ),
    );
  }
}
