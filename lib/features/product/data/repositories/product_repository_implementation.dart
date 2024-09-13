import 'package:dartz/dartz.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

import '../../../../core/error/failure.dart';

class ProductRepositoryImplementation extends ProductRepository {
  final ProductRemoteDatasource productRemoteDataSource;

  ProductRepositoryImplementation({
    required this.productRemoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> addProduct(Product product) async {
    try {
      bool result = await productRemoteDataSource.addProduct(product);
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(String idPrimary) async {
    try {
      bool result = await productRemoteDataSource.deleteProduct(idPrimary);
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProduct() async {
    try {
      List<ProductModel> result =
          await productRemoteDataSource.getAllProducts();
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(String idPrimary) async {
    try {
      ProductModel result = await productRemoteDataSource.getProduct(idPrimary);
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateProduct(Product product) async {
    try {
      bool result = await productRemoteDataSource.updateProduct(product);
      return Right(result);
    } catch (e) {
      return Left(Failure());
    }
  }
}
