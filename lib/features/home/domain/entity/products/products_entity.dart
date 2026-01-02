import 'package:my_template/features/global_entity_model/localized_text/localized_text_entity.dart';
import 'package:my_template/features/home/domain/entity/products/prodcuts_category_entity.dart';

import '../../../data/model/localized_text/localized_text_model.dart';
import '../../../data/model/products/products_category_model.dart';

class ProductsEntity {
  final int id;
  final String slug;
  final LocalizedTextEntity name;
  final double price;
  final double? oldPrice;
  final List<String> images;
  final ProductsCategoryEntity category;

  ProductsEntity({
    required this.id,
    required this.slug,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.images,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': (name as LocalizedTextModel).toJson(),
      'price': price,
      'old_price': oldPrice,
      'images': images,
      'category': (category as ProductsCategoryModel).toJson(),
    };
  }
}
