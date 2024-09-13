import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/add_product.dart';
import '../../domain/usecases/delete_product.dart';
import '../../domain/usecases/update_product.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_all_product.dart';
import '../../domain/usecases/get_product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProduct getAllProduct;
  final GetProduct getProduct;
  final AddProduct addProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  final int batchSize = 12; // Number of items per batch
  List<Product> _allProducts = []; // Store all products here
  List<Product> products = []; // Store all products here
  List<Product> _searchResults = [];
  int _currentIndex = 0;
  ProductBloc({
    required this.getAllProduct,
    required this.getProduct,
    required this.addProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(ProductInitial()) {
    on<GetAllProductEvents>((event, emit) async {
      emit(const ProductLoadingState(LoadingType.all));
      Either<Failure, List<Product>> result = await getAllProduct.execute();
      result.fold((l) {
        if (l is BadRequestException) {
          emit(ProductErrorState(l.toString(), ErrorType.all));
        } else if (l is NotFoundException) {
          emit(ProductErrorState(l.toString(), ErrorType.all));
        } else if (l is InternalServerErrorException) {
          emit(ProductErrorState(l.toString(), ErrorType.all));
        } else if (l is GenericHttpException) {
          emit(ProductErrorState(l.toString(), ErrorType.all));
        } else {
          emit(const ProductErrorState('Unknown Error', ErrorType.all));
        }
      }, (r) {
        _allProducts = r;

        _currentIndex = batchSize;
        products = _allProducts.take(batchSize).toList();

        emit(ProductsLoadedState(products, _allProducts.length));
      });
    });

    on<LoadMoreProductEvent>((event, emit) async {
      if (_currentIndex < _allProducts.length) {
        final nextBatch =
            _allProducts.skip(_currentIndex).take(batchSize).toList();
        _currentIndex += batchSize;

        emit(ProductsLoadedState(
            List.from(products)..addAll(nextBatch), _allProducts.length));
      }
    });

    on<GetProductEvent>((event, emit) async {
      emit(const ProductLoadingState(LoadingType.single));
      Either<Failure, Product> result =
          await getProduct.execute(event.idPrimary);
      result.fold((l) {
        if (l is BadRequestException) {
          emit(ProductErrorState(l.toString(), ErrorType.single));
        } else if (l is NotFoundException) {
          emit(ProductErrorState(l.toString(), ErrorType.single));
        } else if (l is InternalServerErrorException) {
          emit(ProductErrorState(l.toString(), ErrorType.single));
        } else if (l is GenericHttpException) {
          emit(ProductErrorState(l.toString(), ErrorType.single));
        } else {
          emit(const ProductErrorState('Unknown Error', ErrorType.single));
        }
      }, (r) => emit(ProductSingleState(r)));
    });

    on<SearchProductEvent>((event, emit) async {
      emit(const ProductLoadingState(LoadingType.search));
      _searchResults = _allProducts.where((product) {
        return product.name.toLowerCase().contains(event.query.toLowerCase());
      }).toList();

      if (_searchResults.isEmpty) {
        emit(ProductErrorState(
            'No products found for "${event.query}"', ErrorType.search));
      } else {
        emit(ProductsLoadedState(_searchResults, _allProducts.length));
      }
    });

    on<AddProductEvent>((event, emit) async {
      emit(const ProductLoadingState(LoadingType.add));
      Either<Failure, bool> result = await addProduct.execute(event.product);
      result.fold((l) {
        if (l is BadRequestException) {
          emit(ProductErrorState(l.toString(), ErrorType.add));
        } else if (l is NotFoundException) {
          emit(ProductErrorState(l.toString(), ErrorType.add));
        } else if (l is InternalServerErrorException) {
          emit(ProductErrorState(l.toString(), ErrorType.add));
        } else if (l is GenericHttpException) {
          emit(ProductErrorState(l.toString(), ErrorType.add));
        } else {
          emit(const ProductErrorState('Unknown Error', ErrorType.add));
        }
      }, (r) => emit(ProductAddState(r)));
    });

    on<UpdateProductEvent>((event, emit) async {
      emit(const ProductLoadingState(LoadingType.update));
      Either<Failure, bool> result = await updateProduct.execute(event.product);
      result.fold((l) {
        if (l is BadRequestException) {
          emit(ProductErrorState(l.toString(), ErrorType.update));
        } else if (l is NotFoundException) {
          emit(ProductErrorState(l.toString(), ErrorType.update));
        } else if (l is InternalServerErrorException) {
          emit(ProductErrorState(l.toString(), ErrorType.update));
        } else if (l is GenericHttpException) {
          emit(ProductErrorState(l.toString(), ErrorType.update));
        } else {
          emit(const ProductErrorState('Unknown Error', ErrorType.update));
        }
      }, (r) => emit(ProductUpdateState(r)));
    });

    on<DeleteProductEvent>((event, emit) async {
      emit(const ProductLoadingState(LoadingType.delete));
      Either<Failure, bool> result =
          await deleteProduct.execute(event.idPrimary);
      result.fold((l) {
        if (l is BadRequestException) {
          emit(ProductErrorState(l.toString(), ErrorType.update));
        } else if (l is NotFoundException) {
          emit(ProductErrorState(l.toString(), ErrorType.update));
        } else if (l is InternalServerErrorException) {
          emit(ProductErrorState(l.toString(), ErrorType.update));
        } else if (l is GenericHttpException) {
          emit(ProductErrorState(l.toString(), ErrorType.update));
        } else {
          emit(const ProductErrorState('Unknown Error', ErrorType.update));
        }
      }, (r) => emit(ProductDeleteState(r)));
    });
  }
}
