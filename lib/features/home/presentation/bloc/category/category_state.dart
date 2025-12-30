import 'package:my_template/features/home/domain/entity/categories/category_entity.dart';

class CategoryState {
  CategoryState();
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryEntity> entity;

  CategoryLoaded(this.entity);
}

class CategoryError extends CategoryState {}
