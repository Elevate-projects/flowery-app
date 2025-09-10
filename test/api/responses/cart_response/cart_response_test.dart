import 'package:flowery_app/api/responses/cart_response/cart_response.dart';
import 'package:flowery_app/domain/entities/cart/add_product_to_cart/add_product_cart_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('when call cart_response with null it should return null values ', () {
    const AddProductCartEntity cart = AddProductCartEntity(
      message: null,
      numOfCartItems: null,
      cart: null,
    );
    expect(cart.message, null);
    expect(cart.numOfCartItems, null);
    expect(cart.cart, null);
  });

  test('when call cart_response should convert to entity ', () {
    // Arrange
    final json = {
      "message": "success",
      "numOfCartItems": 1,
      "cart": {
        "_id": "cart123",
        "user": "user123",
        "cartItems": [
          {
            "product": {
              "productId": "product123",
              "title": "product title",
            }
          }
        ]
      }
    };

    // Act
    final cart = CartResponse.fromJson(json).toEntity();

    // Assert
    expect(cart.message, "success");
    expect(cart.numOfCartItems, 1);
    expect(cart.cart?.id, "cart123");
    expect(cart.cart?.user, "user123");
    expect(cart.cart?.cartItems?.first.product?.title, "product title");
  });
}
