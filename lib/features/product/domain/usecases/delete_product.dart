import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository productRepository;

  DeleteProduct(this.productRepository);

  Future<Either<Failure, bool>> execute(String idPrimary) async {
    return await productRepository.deleteProduct(idPrimary);
  }
}
