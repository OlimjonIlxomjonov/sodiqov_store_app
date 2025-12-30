import 'package:my_template/features/home/domain/entity/categories/category_entity.dart';
import 'package:my_template/features/home/domain/repository/home_repository.dart';

class CategoryUseCase {
  final HomeRepository repository;

  CategoryUseCase(this.repository);

  Future<List<CategoryEntity>> call() {
    return repository.getCategory();
  }
}
