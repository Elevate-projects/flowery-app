import 'dart:math';

import 'package:flowery_app/api/models/register/user_register_model.dart';
import 'package:flowery_app/domain/entities/user_data/user_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("test toUserDataEntity",(){
  test("when call to UserDataEntity with null values it should return UserDataEntity with null values",(){
    //Arrange
    UserRegisterModel userRegisterModel = UserRegisterModel(
      id: null,
      email: null,
      phone: null,
      firstName: null,
      lastName: null,
      gender: null,
      photo: null,
      addresses: null,
      wishlist: null,
      createdAt: null,
      role: null,
    );
    //Act
    UserDataEntity actualResult =userRegisterModel.toUserDataEntity();
    //Assert
    expect(actualResult.userId, isNull);
    expect(actualResult.email, isNull);
    expect(actualResult.phone, isNull);
    expect(actualResult.firstName, isNull);
    expect(actualResult.lastName, isNull);
    expect(actualResult.gender, isNull);
    expect(actualResult.photo, isNull);
    expect(actualResult.addresses, isNull);
    expect(actualResult.wishlist, isNull);
    expect(actualResult.createdAt, isNull);
    expect(actualResult.role, isNull);
  });
  test("when call to UserDataEntity with non null values it should return UserDataEntity with same values",(){
    //Arrange
 UserRegisterModel userRegisterModel = UserRegisterModel(
      id: "1",
      email: "test@example.com",
      phone: "1234567890",
      firstName: "John",
      lastName: "Doe",
      gender: "Male",
      photo: "photo.jpg",
      addresses: ["haram","faisel"],
      wishlist: ["item1", "item2"],
      createdAt: "2025-01-01",
      role: "user",
    );
    //Act
    UserDataEntity actualResult =userRegisterModel.toUserDataEntity();
    //Assert
    expect(actualResult.userId, equals(userRegisterModel.id));
    expect(actualResult.email, equals(userRegisterModel.email));
    expect(actualResult.phone, equals(userRegisterModel.phone));
    expect(actualResult.firstName, equals(userRegisterModel.firstName));
    expect(actualResult.lastName, equals(userRegisterModel.lastName));
    expect(actualResult.gender, equals(userRegisterModel.gender));
    expect(actualResult.photo, equals(userRegisterModel.photo));
    expect(actualResult.addresses, equals(userRegisterModel.addresses));
    expect(actualResult.wishlist, equals(userRegisterModel.wishlist));
    expect(actualResult.createdAt, equals(userRegisterModel.createdAt));
    expect(actualResult.role, equals(userRegisterModel.role));

  });

});}