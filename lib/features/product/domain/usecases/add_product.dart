import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class AddProduct {
  final ProductRepository productRepository;

  AddProduct(this.productRepository);

  Future<Either<Failure, bool>> execute(Product product) async {
    return await productRepository.addProduct(product);
  }
}
