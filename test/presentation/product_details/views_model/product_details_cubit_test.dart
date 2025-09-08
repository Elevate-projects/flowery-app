import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_cubit.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_intent.dart';
import 'package:flowery_app/presentation/product_details/views_model/product_details_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProductDetailsCubit cubit;
  late final ProductCardEntity productCardData;

  setUpAll(() {
    productCardData = const ProductCardEntity(
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
      categoryId: "673c46fd1159920171827c85",
      occasionId: "673b34c21159920171827ae0",
      sold: 259,
      productId: "6745096c90ab40a0685402fc",
      discountPercentage: "20%",
    );
  });

  setUp(() {
    cubit = ProductDetailsCubit();
  });

  group("Product Details cubit test", () {
    blocTest<ProductDetailsCubit, ProductDetailsState>(
      'emits ProductDetailsState when InitializeProductDetailsIntent is called',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        intent: InitializeProductDetailsIntent(
          productCardData: productCardData,
        ),
      ),
      expect: () => [
        isA<ProductDetailsState>()
            .having(
              (state) => state.productImages?.length,
              "is the product Images items = 4",
              equals(4),
            )
            .having(
              (state) => state.isInStock,
              "as its quantity = 4741 it should returns true",
              equals(true),
            ),
      ],
    );
  });
}
