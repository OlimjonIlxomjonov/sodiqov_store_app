import 'package:my_template/features/home/domain/entity/products/products_entity.dart';
import 'package:my_template/features/home/domain/repository/home_repository.dart';

class ProductsBySlugUseCase {
  final HomeRepository repository;

  ProductsBySlugUseCase(this.repository);

  Future<ProductsEntity> call({required String slug}) {
    return repository.getProductsBySlug(slug: slug);
  }
}
