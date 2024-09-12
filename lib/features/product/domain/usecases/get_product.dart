import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProduct {
  final ProductRepository productRepository;

  GetProduct(this.productRepository);

  Future<Either<Failure, Product>> execute(String idPrimary) async {
    return await productRepository.getProduct(idPrimary);
  }
}
