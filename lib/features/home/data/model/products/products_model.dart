import 'package:my_template/features/home/data/model/products/products_category_model.dart';
import 'package:my_template/features/home/domain/entity/products/products_entity.dart';

import '../localized_text/localized_text_model.dart';

class ProductsModel extends ProductsEntity {
  ProductsModel({
    required super.id,
    required super.slug,
    required super.name,
    required super.price,
    required super.oldPrice,
    required super.images,
    required super.category,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      slug: json['slug'],
      name: LocalizedTextModel.fromJson(json['name']),
      price: double.parse(json['price'].toString()),
      oldPrice: json['old_price'] != null
          ? double.parse(json['old_price'].toString())
          : null,
      images: List<String>.from(json['images']),
      category: ProductsCategoryModel.fromJson(json['category']),
    );
  }
}
