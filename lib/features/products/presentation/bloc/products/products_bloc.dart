// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:internship_assignment/features/products/domain/entity/product_entity.dart';
import 'package:internship_assignment/features/products/domain/usecases/fetch_products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final FetchProducts fetchProducts;
  ProductsBloc(
    this.fetchProducts,
  ) : super(ProductsInitial()) {
    on<OnFetchProducts>(_fetchProducts);
  }

  FutureOr<void> _fetchProducts(
      OnFetchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());

    final reponse = await fetchProducts.call();

    reponse.fold((error) => emit(ProductsFailure(error: error.message)),
        (products) => emit(ProductsLoaded(products: products)));
  }
}
