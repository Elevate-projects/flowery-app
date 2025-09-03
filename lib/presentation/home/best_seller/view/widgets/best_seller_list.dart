import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flowery_app/utils/common_widgets/product_card_item/product_card_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerList extends StatelessWidget {
  BestSellerList({super.key});

  final List<ProductCardEntity> products = [
    ProductCardEntity(
      title: "Red roses",
      slug: "flower",
      description: "flower desc",
      imgCover:
          "https://flower.elevateegy.com/uploads/2d8ddf11-935f-4a45-a100-e1e0765a39c3-cover_image.png",
      images: [
        "https://flower.elevateegy.com/uploads/8ee8e389-da6a-4371-8b13-5e35fcca16c6-image_one.png",
        "https://flower.elevateegy.com/uploads/66fc9304-3ceb-4b73-97dd-730ccf790c49-image_three.png",
        "https://flower.elevateegy.com/uploads/acf9531b-5ca9-4c45-97fc-f81df9d62091-image_two.png",
      ],
      price: 800,
      priceAfterDiscount: 600,
      quantity: 1,
      category: "Category",
      occasion: "Occasion",
      sold: 1,
      productId: "1",
      discountPercentage: "20%",
    ),
    ProductCardEntity(
      title: "White tulips",
      slug: "flower",
      description: "beautiful white tulips",
      imgCover: "https://example.com/white-tulips-cover.png",
      images: [
        "https://example.com/white-tulips-1.png",
        "https://example.com/white-tulips-2.png",
      ],
      price: 500,
      priceAfterDiscount: 450,
      quantity: 1,
      category: "Category",
      occasion: "Occasion",
      sold: 2,
      productId: "2",
      discountPercentage: "10%",
    ),
    ProductCardEntity(
      title: "White tulips",
      slug: "flower",
      description: "beautiful white tulips",
      imgCover: "https://example.com/white-tulips-cover.png",
      images: [
        "https://example.com/white-tulips-1.png",
        "https://example.com/white-tulips-2.png",
      ],
      price: 500,
      priceAfterDiscount: 450,
      quantity: 1,
      category: "Category",
      occasion: "Occasion",
      sold: 2,
      productId: "2",
      discountPercentage: "10%",
    ),
    ProductCardEntity(
      title: "White tulips",
      slug: "flower",
      description: "beautiful white tulips",
      imgCover: "https://example.com/white-tulips-cover.png",
      images: [
        "https://example.com/white-tulips-1.png",
        "https://example.com/white-tulips-2.png",
      ],
      price: 500,
      priceAfterDiscount: 450,
      quantity: 1,
      category: "Category",
      occasion: "Occasion",
      sold: 2,
      productId: "2",
      discountPercentage: "10%",
    ),
    ProductCardEntity(
      title: "White tulips",
      slug: "flower",
      description: "beautiful white tulips",
      imgCover: "https://example.com/white-tulips-cover.png",
      images: [
        "https://example.com/white-tulips-1.png",
        "https://example.com/white-tulips-2.png",
      ],
      price: 500,
      priceAfterDiscount: 450,
      quantity: 1,
      category: "Category",
      occasion: "Occasion",
      sold: 2,
      productId: "2",
      discountPercentage: "10%",
    ),
    ProductCardEntity(
      title: "White tulips",
      slug: "flower",
      description: "beautiful white tulips",
      imgCover: "https://example.com/white-tulips-cover.png",
      images: [
        "https://example.com/white-tulips-1.png",
        "https://example.com/white-tulips-2.png",
      ],
      price: 500,
      priceAfterDiscount: 450,
      quantity: 1,
      category: "Category",
      occasion: "Occasion",
      sold: 2,
      productId: "2",
      discountPercentage: "10%",
    ),
    ProductCardEntity(
      title: "White tulips",
      slug: "flower",
      description: "beautiful white tulips",
      imgCover: "https://example.com/white-tulips-cover.png",
      images: [
        "https://example.com/white-tulips-1.png",
        "https://example.com/white-tulips-2.png",
      ],
      price: 500,
      priceAfterDiscount: 450,
      quantity: 1,
      category: "Category",
      occasion: "Occasion",
      sold: 2,
      productId: "2",
      discountPercentage: "10%",
    ),
    ProductCardEntity(
      title: "White tulips",
      slug: "flower",
      description: "beautiful white tulips",
      imgCover: "https://example.com/white-tulips-cover.png",
      images: [
        "https://example.com/white-tulips-1.png",
        "https://example.com/white-tulips-2.png",
      ],
      price: 500,
      priceAfterDiscount: 450,
      quantity: 1,
      category: "Category",
      occasion: "Occasion",
      sold: 2,
      productId: "2",
      discountPercentage: "10%",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 17.r,
          mainAxisSpacing: 17.r,
          childAspectRatio: 1 / 1.44,
        ),
        itemBuilder: (context, index) =>
            ProductCardItem(productCardData: products[index]),
        itemCount: products.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
