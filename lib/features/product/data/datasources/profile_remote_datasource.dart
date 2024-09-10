import '../../domain/entities/product.dart';

abstract class ProfileRemoteDatasource {
  Future<Product> getProduct(int idPrimary);
  Future<List<Product>> getAllProducts();
  Future<bool> addProduct(Product product);
  Future<bool> updateProduct(Product product);
  Future<bool> deleteProduct(int idPrimary);
}

class ProfileRemoteDataSourceImplements implements ProfileRemoteDatasource {
  @override
  Future<bool> addProduct(Product product) {
    // TODO: implement addProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteProduct(int idPrimary) {
    // TODO: implement deleteProduct
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  Future<Product> getProduct(int idPrimary) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<bool> updateProduct(Product product) {
    // TODO: implement updateProduct
    throw UnimplementedError();
  }
}
