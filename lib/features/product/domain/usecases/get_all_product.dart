import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetAllProduct {
  final ProductRepository productRepository;

  GetAllProduct(this.productRepository);

  Future<Either<Failure, List<Product>>> execute() async {
    return await productRepository.getAllProduct();
  }
}
