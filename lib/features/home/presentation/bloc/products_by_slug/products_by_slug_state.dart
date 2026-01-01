import 'package:my_template/features/home/domain/entity/products/products_entity.dart';

class ProductsBySlugState {
  ProductsBySlugState();
}

class ProductsBySlugInitial extends ProductsBySlugState {}

class ProductsBySlugLoading extends ProductsBySlugState {}

class ProductsBySlugLoaded extends ProductsBySlugState {
  final ProductsEntity entity;

  ProductsBySlugLoaded(this.entity);
}

class ProductsBySlugError extends ProductsBySlugState {}
