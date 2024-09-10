import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class UpdateProduct {
  final ProductRepository productRepository;
  UpdateProduct(this.productRepository);

  Future<Either<Failure, bool>> excecute(Product product) async {
    return await productRepository.updateProduct(product);
  }
}
