import 'package:flowery_app/api/models/product_card/product_card_model.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test toUserDataEntity", () {
    test(
      "when call toProductCardEntity with null values it should return ProductCardEntity with null values",
      () {
        //Arrange
        final ProductCardModel productCardData = ProductCardModel(
          rateAvg: null,
          rateCount: null,
          id: null,
          title: null,
          slug: null,
          productId: null,
          category: null,
          createdAt: null,
          description: null,
          images: null,
          imgCover: null,
          isSuperAdmin: null,
          occasion: null,
          price: null,
          priceAfterDiscount: null,
          quantity: null,
          sold: null,
          updatedAt: null,
          v: null,
        );

        //Act
        final ProductCardEntity actualResult = productCardData
            .toProductCardEntity();

        //Assert
        expect(actualResult.productId, equals(productCardData.productId));
        expect(actualResult.title, equals(productCardData.title));
        expect(actualResult.slug, equals(productCardData.slug));
        expect(actualResult.description, equals(productCardData.description));
        expect(actualResult.imgCover, equals(productCardData.imgCover));
        expect(actualResult.images, equals(productCardData.images));
        expect(actualResult.price, equals(productCardData.price));
        expect(
          actualResult.priceAfterDiscount,
          equals(productCardData.priceAfterDiscount),
        );
        expect(actualResult.quantity, equals(productCardData.quantity));
        expect(actualResult.categoryId, equals(productCardData.category));
        expect(actualResult.occasionId, equals(productCardData.occasion));
        expect(actualResult.discountPercentage, isNull);
      },
    );
    test(
      "when call toProductCardEntity with non-nullable values it should return ProductCardEntity with correct values",
      () {
        //Arrange
        final ProductCardModel productCardData = ProductCardModel(
          rateAvg: 4,
          rateCount: 10,
          id: "1",
          title: "Product 1",
          slug: "product-1",
          productId: "p1",
          category: "Category 1",
          createdAt: "2023-01-01",
          description: "Description 1",
          images: ["img1", "img2"],
          imgCover: "imgCover1",
          isSuperAdmin: false,
          occasion: "Occasion 1",
          price: 100,
          priceAfterDiscount: 80,
          quantity: 50,
          sold: 20,
          updatedAt: "2023-01-02",
          v: 0,
        );

        //Act
        final ProductCardEntity actualResult = productCardData
            .toProductCardEntity();

        //Assert
        expect(actualResult.productId, equals(productCardData.productId));
        expect(actualResult.title, equals(productCardData.title));
        expect(actualResult.slug, equals(productCardData.slug));
        expect(actualResult.description, equals(productCardData.description));
        expect(actualResult.imgCover, equals(productCardData.imgCover));
        expect(actualResult.images, equals(productCardData.images));
        expect(actualResult.price, equals(productCardData.price));
        expect(
          actualResult.priceAfterDiscount,
          equals(productCardData.priceAfterDiscount),
        );
        expect(actualResult.quantity, equals(productCardData.quantity));
        expect(actualResult.categoryId, equals(productCardData.category));
        expect(actualResult.occasionId, equals(productCardData.occasion));
        expect(actualResult.discountPercentage, isNotNull);
      },
    );
  });
}
