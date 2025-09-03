import 'package:flowery_app/core/di/di.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/product_details/views/widgets/product_details_view_body.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_cubit.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductCardEntity productCardData = ProductCardEntity(
      title: "Forever Pink | Baby Roses",
      slug: "forever-pink-or-baby-roses",
      description:
          "A gift of pink baby roses holds profound meaning. It symbolizes love, gratitude, and appreciation, making it a perfect choice for any occasion. The soft, feminine hue of pink baby roses embodies notions of nurturing and emotional love. They are also a gentle way to express sympathy or convey a message filled with kindness. These pink baby roses represent a significant gesture of love or a heartfelt wish for good luck and happiness. Embrace the power of pink roses to convey your emotions and leave a lasting impression.",
      imgCover:
          "https://flower.elevateegy.com/uploads/336d4a68-109d-4f29-a35c-d5ca2215b4ff-cover_image.png",
      images: [
        "https://flower.elevateegy.com/uploads/ef146ee3-ac7c-4bbd-a2f7-9ddae14d0656-image_four.png",
        "https://flower.elevateegy.com/uploads/6e1fa180-7b99-4dd5-95f0-032715a0f04e-image_one.png",
        "https://flower.elevateegy.com/uploads/3594e620-5411-4c6f-bf4f-188e312ee391-image_three.png",
        "https://flower.elevateegy.com/uploads/8cfb2f72-c8e8-47f6-bf10-70f43b3e0fed-image_two.png",
      ],
      price: 2049,
      priceAfterDiscount: 1899,
      quantity: 4741,
      category: "673c46fd1159920171827c85",
      occasion: "673b34c21159920171827ae0",
      sold: 259,
      productId: "6745096c90ab40a0685402fc",
      discountPercentage: "20%",
    );
    return BlocProvider<ProductDetailsCubit>(
      create: (context) => getIt.get<ProductDetailsCubit>()
        ..doIntent(
          intent: InitializeProductDetailsIntent(
            productCardData: productCardData,
          ),
        ),
      child: Scaffold(
        body: ProductDetailsViewBody(productCardData: productCardData),
      ),
    );
  }
}
