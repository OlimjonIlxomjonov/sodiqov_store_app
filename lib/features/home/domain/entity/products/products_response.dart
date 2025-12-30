import 'package:my_template/features/global_entity_model/pagination/pagination_meta_entity.dart';
import 'package:my_template/features/home/domain/entity/products/products_entity.dart';

class ProductsResponse {
  final List<ProductsEntity> data;
  final PaginationMetaEntity paginationMeta;

  ProductsResponse({required this.data, required this.paginationMeta});

  ProductsResponse copyWith({
    List<ProductsEntity>? data,
    PaginationMetaEntity? paginationMeta,
  }) {
    return ProductsResponse(
      data: data ?? this.data,
      paginationMeta: paginationMeta ?? this.paginationMeta,
    );
  }
}
