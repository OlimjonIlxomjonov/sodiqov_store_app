import 'package:my_template/core/commons/constants/api_urls/api_urls.dart';
import 'package:my_template/core/network/dio_client.dart';
import 'package:my_template/core/utils/logger/logger.dart';
import 'package:my_template/features/home/data/model/category/category_model.dart';
import 'package:my_template/features/home/data/model/products/products_response_model.dart';
import 'package:my_template/features/home/data/source/remote_data_source/home_remote_data_source.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final dioClient = DioClient();

  @override
  Future<List<CategoryModel>> fetchCategory() async {
    try {
      final response = await dioClient.get(ApiUrls.categories);
      if (response.statusCode == 200 || response.statusCode == 200) {
        logger.i('SUCCESS!: ${response.data}');
        final data = response.data['data'] as List;
        return data.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        throw Exception('ERROR OCCURRED: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('ERROR $e');
      rethrow;
    }
  }

  @override
  Future<ProductsResponseModel> fetchProducts({required int page}) async {
    try {
      final response = await dioClient.get("${ApiUrls.products}?page=$page");
      if (response.statusCode == 200 || response.statusCode == 200) {
        logger.i('SUCCESS!: ${response.data}');
        logger.f("${ApiUrls.products}?page=$page");
        final data = response.data;
        return ProductsResponseModel.fromJson(data);
      } else {
        throw Exception('ERROR OCCURRED: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('ERROR $e');
      rethrow;
    }
  }
}
