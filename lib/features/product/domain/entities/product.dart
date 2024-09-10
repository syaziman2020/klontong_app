import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String idPrimary;
  final int id;
  final String category;
  final String sku;
  final String name;
  final String description;
  final int weight;
  final int width;
  final int height;
  final int length;
  final String image;
  final int price;

  const Product({
    required this.idPrimary,
    required this.id,
    required this.name,
    required this.category,
    required this.sku,
    required this.description,
    required this.weight,
    required this.width,
    required this.height,
    required this.length,
    required this.image,
    required this.price,
  });

  @override
  List<Object?> get props => [
        idPrimary,
        id,
        name,
        category,
        sku,
        description,
        weight,
        width,
        height,
        length,
        image,
        price,
      ];
}
