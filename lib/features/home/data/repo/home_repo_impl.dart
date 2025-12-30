import 'package:my_template/features/home/data/source/remote_data_source/home_remote_data_source.dart';
import 'package:my_template/features/home/domain/entity/categories/category_entity.dart';
import 'package:my_template/features/home/domain/entity/products/products_response.dart';
import 'package:my_template/features/home/domain/repository/home_repository.dart';

class HomeRepoImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepoImpl(this.remoteDataSource);

  @override
  Future<List<CategoryEntity>> getCategory() {
    return remoteDataSource.fetchCategory();
  }

  @override
  Future<ProductsResponse> getProducts({required int page}) {
    return remoteDataSource.fetchProducts(page: page);
  }
}
