import 'package:my_template/features/home/data/model/category/category_model.dart';
import 'package:my_template/features/home/data/model/products/products_response_model.dart';
import 'package:my_template/features/home/domain/entity/products/products_response.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> fetchCategory();

  Future<ProductsResponseModel> fetchProducts({required int page});
}
