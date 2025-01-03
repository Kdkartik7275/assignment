part of 'products_bloc.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsLoaded extends ProductsState {
  final List<ProductEntity> products;

  const ProductsLoaded({required this.products});
}

final class ProductsFailure extends ProductsState {
  final String error;

  const ProductsFailure({required this.error});
}
