// /lib/presentation/viewmodel/product_state.dart
part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
const ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductCompared extends ProductState {
  final List<ProductModel> comparedProducts;
 const ProductCompared(this.comparedProducts);

  @override
  List<Object?> get props => [comparedProducts];
}