import 'package:my_template/features/home/domain/entity/products/prodcuts_category_entity.dart';

import '../localized_text/localized_text_model.dart';

class ProductsCategoryModel extends ProductsCategoryEntity {
  ProductsCategoryModel({
    required super.id,
    required super.slug,
    required super.name,
  });

  factory ProductsCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductsCategoryModel(
      id: json['id'],
      slug: json['slug'],
      name: LocalizedTextModel.fromJson(json['name']),
    );
  }
}
