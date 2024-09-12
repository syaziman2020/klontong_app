part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetAllProductEvents extends ProductEvent {
  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductEvent {
  final String idPrimary;
  const GetProductEvent(this.idPrimary);
  @override
  List<Object> get props => [idPrimary];
}

class AddProductEvent extends ProductEvent {
  final Product product;
  const AddProductEvent(this.product);
  @override
  List<Object> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  const UpdateProductEvent(this.product);
  @override
  List<Object> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final String idPrimary;
  const DeleteProductEvent(this.idPrimary);
  @override
  List<Object> get props => [idPrimary];
}
