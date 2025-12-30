import 'package:my_template/features/home/domain/entity/products/products_response.dart';

class ProductsState {
  ProductsState();
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final ProductsResponse response;

  ProductsLoaded(this.response);
}

class ProductsError extends ProductsState {}
