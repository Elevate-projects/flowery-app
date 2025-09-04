import 'package:flowery_app/api/models/home_products_model/category_model.dart';
import 'package:flowery_app/domain/entities/home_products/category_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('category model', (){
    test("when call toEntity with null values it should return null",(){
      //arrange
        CategoryModel categoryModel = const CategoryModel(
       id: null,
        name: null,
        createdAt: null,
        image: null,
        isSuperAdmin: null,
        slug: null,
        updatedAt: null,
      );
      //act
      CategoryEntity actualResult = categoryModel.toEntity();
      //assert
      expect(actualResult.id, isNull);
      expect(actualResult.name, isNull);
      expect(actualResult.createdAt, isNull);
      expect(actualResult.image, isNull);
      expect(actualResult.isSuperAdmin, equals(categoryModel.isSuperAdmin?? false));
      expect(actualResult.slug, isNull);
      expect(actualResult.updatedAt, isNull);
    });

     test("when call toEntity with values it should return correct values",(){
      //arrange
        CategoryModel categoryModel = const CategoryModel(
       id: '1',
        name: "Electronics",
        createdAt: '2023-10-01T12:00:00Z',
        image: "image_url",
        isSuperAdmin: true,
        slug: "electronics",
        updatedAt: '2023-10-01T12:00:00Z',
      );
      //act
      CategoryEntity actualResult = categoryModel.toEntity();
      //assert
      expect(actualResult.id, equals(categoryModel.id));
      expect(actualResult.name, equals(categoryModel.name));
      expect(actualResult.createdAt, equals(categoryModel.createdAt));
      expect(actualResult.image, equals(categoryModel.image));
      expect(actualResult.isSuperAdmin, equals(categoryModel.isSuperAdmin));
      expect(actualResult.slug, equals(categoryModel.slug));
      expect(actualResult.updatedAt, equals(categoryModel.updatedAt));
    });
  });
}