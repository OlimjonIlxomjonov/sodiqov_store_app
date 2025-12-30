import 'package:my_template/features/home/data/model/products/products_model.dart';
import 'package:my_template/features/home/domain/entity/products/products_response.dart';

import '../../../../global_entity_model/pagination/pagination_meta_entity.dart';

class ProductsResponseModel extends ProductsResponse {
  ProductsResponseModel({required super.data, required super.paginationMeta});

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsResponseModel(
      data: (json['data'] as List)
          .map((e) => ProductsModel.fromJson(e))
          .toList(),
      paginationMeta: PaginationMetaEntity.fromJson(json['meta']),
    );
  }
}
