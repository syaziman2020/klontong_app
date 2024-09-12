import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.category,
    required super.sku,
    required super.name,
    required super.description,
    required super.weight,
    required super.width,
    required super.length,
    required super.height,
    required super.image,
    required super.price,
    super.idPrimary,
  });

  factory ProductModel.fromProduct(Product product) {
    return ProductModel(
      id: product.id,
      category: product.category,
      sku: product.sku,
      name: product.name,
      description: product.description,
      weight: product.weight,
      width: product.width,
      length: product.length,
      height: product.height,
      image: product.image,
      price: product.price,
      idPrimary: product.idPrimary,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      category: json['categoryName'],
      sku: json['sku'],
      name: json['name'],
      description: json['description'],
      weight: json['weight'],
      width: json['width'],
      length: json['length'],
      height: json['height'],
      image: json['image'],
      price: json['harga'],
      idPrimary: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryName'] = category;
    data['sku'] = sku;
    data['name'] = name;
    data['description'] = description;
    data['weight'] = weight;
    data['width'] = width;
    data['length'] = length;
    data['height'] = height;
    data['image'] = image;
    data['harga'] = price;
    return data;
  }

  static List<ProductModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    return data.map((e) => ProductModel.fromJson(e)).toList();
  }
}
