import 'package:dio/dio.dart';

import '../../../../core/constants/main_url.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProduct(String idPrimary);
  Future<bool> addProduct(Product product);
  Future<bool> updateProduct(Product product);
  Future<bool> deleteProduct(String idPrimary);
}

class ProductRemoteDataSourceImplements implements ProductRemoteDatasource {
  final Dio dio;

  ProductRemoteDataSourceImplements({required this.dio});

  @override
  Future<bool> addProduct(Product product) async {
    try {
      final ProductModel productModel = ProductModel.fromProduct(product);

      final response = await dio.post(
        '${MainUrl.url}/products',
        data: productModel.toJson(),
      );

      if (response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 400) {
        throw BadRequestException('Invalid request: ${response.data['title']}');
      } else if (response.statusCode == 404) {
        throw NotFoundException('Not Found: ${response.data['title']}');
      } else if (response.statusCode == 500) {
        throw InternalServerErrorException(
            'Internal Server Error: ${response.data['title']}');
      } else {
        throw GenericHttpException(
            'Unexpected error: ${response.data['title']}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<bool> deleteProduct(String idPrimary) async {
    try {
      final response = await dio.delete('${MainUrl.url}/products/$idPrimary');
      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw BadRequestException('Invalid request: ${response.data['title']}');
      } else if (response.statusCode == 404) {
        throw NotFoundException('Product not found: ${response.data['title']}');
      } else if (response.statusCode == 500) {
        throw InternalServerErrorException(
            'Internal Server Error: ${response.data['title']}');
      } else {
        throw GenericHttpException(
            'Unexpected error: ${response.data['title']}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await dio.get('${MainUrl.url}/products');

      if (response.statusCode == 200) {
        List<dynamic> data =
            response.data is List<dynamic> ? response.data : [];

        return ProductModel.fromJsonList(data);
      } else if (response.statusCode == 400) {
        throw BadRequestException('Invalid request: ${response.data['title']}');
      } else if (response.statusCode == 404) {
        throw NotFoundException('Not Found: ${response.data['title']}');
      } else if (response.statusCode == 500) {
        throw InternalServerErrorException(
            'Internal Server Error: ${response.data['title']}');
      } else {
        throw GenericHttpException(
            'Unexpected error: ${response.data['title']}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<bool> updateProduct(Product product) async {
    try {
      final ProductModel productModel = ProductModel.fromProduct(product);
      final response = await dio.put(
          '${MainUrl.url}/products/${productModel.idPrimary}',
          data: productModel.toJson());

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 400) {
        throw BadRequestException('Invalid request: ${response.data['title']}');
      } else if (response.statusCode == 404) {
        throw NotFoundException('${response.data['title']}');
      } else if (response.statusCode == 500) {
        throw InternalServerErrorException(
            'Internal Server Error: ${response.data['title']}');
      } else {
        throw GenericHttpException(
            'Unexpected error: ${response.data['title']}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<ProductModel> getProduct(String idPrimary) async {
    try {
      final response = await dio.get('${MainUrl.url}/products/$idPrimary');

      if (response.statusCode == 200) {
        // final ProductModel productModel = ProductModel.fromProduct(product);
        return ProductModel.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw BadRequestException('Invalid request: ${response.data['title']}');
      } else if (response.statusCode == 404) {
        throw NotFoundException('Not Found: ${response.data['title']}');
      } else if (response.statusCode == 500) {
        throw InternalServerErrorException(
            'Internal Server Error: ${response.data['title']}');
      } else {
        throw GenericHttpException(
            'Unexpected error: ${response.data['title']}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
