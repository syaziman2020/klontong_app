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
}

class ProductsLoadedState extends ProductState {
  final List<Product> products;
  const ProductsLoadedState(this.products);

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
  final Product updatedProduct;
  const ProductUpdateState(this.updatedProduct);
  @override
  List<Object> get props => [updatedProduct];
}

class ProductAddState extends ProductState {
  final bool result;
  const ProductAddState(this.result);
  @override
  List<Object> get props => [result];
}

class ProductDeleteState extends ProductState {
  final String idPrimary;
  const ProductDeleteState(this.idPrimary);

  @override
  List<Object> get props => [idPrimary];
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
}
