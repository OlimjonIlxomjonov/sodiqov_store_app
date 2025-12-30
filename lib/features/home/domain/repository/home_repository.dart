import 'package:my_template/features/home/domain/entity/categories/category_entity.dart';
import 'package:my_template/features/home/domain/entity/products/products_response.dart';

abstract class HomeRepository {
  Future<List<CategoryEntity>> getCategory();

  Future<ProductsResponse> getProducts({required int page});
}
