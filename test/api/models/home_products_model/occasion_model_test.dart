import 'package:flowery_app/api/models/home_products_model/occasion_model.dart';
import 'package:flowery_app/domain/entities/home_products/occasions_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('occasion model', (){
    test("when call toEntity with null values it should return null",(){
      //arrange
        final OccasionModel occasionModel = const OccasionModel(
       id: null,
        name: null,
        createdAt: null,
        image: null,
        isSuperAdmin: null,
        slug: null,
        updatedAt: null,
      );
      //act
      final OccasionEntity actualResult = occasionModel.toEntity();
      //assert
      expect(actualResult.id, isNull);
      expect(actualResult.name, isNull);
      expect(actualResult.createdAt, isNull);
      expect(actualResult.image, isNull);
      expect(actualResult.isSuperAdmin, equals(occasionModel.isSuperAdmin?? false));
      expect(actualResult.slug, isNull);
      expect(actualResult.updatedAt, isNull);
    });

     test("when call toEntity with values it should return correct values",(){
      //arrange
        final OccasionModel occasionModel = const OccasionModel(
       id: '1',
        name: "Birthday",
        createdAt: '2023-10-01T12:00:00Z',
        image: "image_url",
        isSuperAdmin: true,
        slug: "birthday",
        updatedAt: '2023-10-01T12:00:00Z',
      );
      //act
      final OccasionEntity actualResult = occasionModel.toEntity();
      //assert
      expect(actualResult.id, equals(occasionModel.id));
      expect(actualResult.name, equals(occasionModel.name));
      expect(actualResult.createdAt, equals(occasionModel.createdAt));
      expect(actualResult.image, equals(occasionModel.image));
      expect(actualResult.isSuperAdmin, equals(occasionModel.isSuperAdmin));
      expect(actualResult.slug, equals(occasionModel.slug));
      expect(actualResult.updatedAt, equals(occasionModel.updatedAt));
    });
  });
}