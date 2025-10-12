import 'package:equatable/equatable.dart';
import 'package:flowery_app/domain/entities/product_card/product_card_entity.dart';

final class OrderItemEntity extends Equatable {
  final ProductCardEntity? product;

  final int? price;

  final int? quantity;

  final String? id;

  const OrderItemEntity({this.product, this.price, this.quantity, this.id});

  @override
  List<Object?> get props => [product, price, quantity, id];
}
