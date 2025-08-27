import '../../product_card/product_card_entity.dart';

final fakeProducts = [
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
    occasion: "Wedding",
    sold: 1,
    productId: "1",
    discountPercentage: "20%",
  ),

];
