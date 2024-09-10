import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProduct();
  Future<Either<Failure, Product>> getProductById(int idPrimary);
  Future<Either<Failure, bool>> addProduct(Product product);
  Future<Either<Failure, bool>> updateProduct(Product product);
  Future<Either<Failure, bool>> deleteProduct(int idPrimary);
}
