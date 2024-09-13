part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {
  final LoadingType type;

  const ProductLoadingState(this.type);

  @override
  List<Object> get props => [type];
}

enum LoadingType {
  all, // For ProductAllLoading
  single, // For ProductLoading
  update, // For ProductUpdateLoading
  add, // For ProductAddLoading
  delete, // For ProductDeleteLoading
  search,
}

class ProductsLoadedState extends ProductState {
  final List<Product> products;
  final int totalProduct;

  const ProductsLoadedState(
    this.products,
    this.totalProduct,
  );

  @override
  List<Object> get props => [products];
}

class ProductSingleState extends ProductState {
  final Product product;
  const ProductSingleState(this.product);
  @override
  List<Object> get props => [product];
}

class ProductUpdateState extends ProductState {
  final bool result;
  const ProductUpdateState(this.result);
  @override
  List<Object> get props => [result];
}

class ProductAddState extends ProductState {
  final bool result;
  const ProductAddState(this.result);
  @override
  List<Object> get props => [result];
}

class ProductDeleteState extends ProductState {
  final bool result;
  const ProductDeleteState(this.result);

  @override
  List<Object> get props => [result];
}

class ProductErrorState extends ProductState {
  final String error;
  final ErrorType type;

  const ProductErrorState(this.error, this.type);

  @override
  List<Object> get props => [error, type];
}

enum ErrorType {
  add, // For ProductAddErrorState
  all, // For ProductAllErrorState
  single, // For individual product errors
  update, // For update errors
  delete, // For delete errors
  search,
}

class ProductSearchResultState extends ProductState {
  final List<Product> searchResults;
  const ProductSearchResultState(this.searchResults);
}
