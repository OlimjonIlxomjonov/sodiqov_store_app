import 'package:my_template/features/home/domain/entity/products/products_response.dart';
import 'package:my_template/features/home/domain/repository/home_repository.dart';

class ProductsUseCase {
  final HomeRepository repository;

  ProductsUseCase(this.repository);

  Future<ProductsResponse> call({required int page}) {
    return repository.getProducts(page: page);
  }
}
