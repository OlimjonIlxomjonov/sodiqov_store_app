import 'package:my_template/features/home/domain/entity/categories/category_entity.dart';

import '../localized_text/localized_text_model.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.id,
    required super.slug,
    required super.name,
    required super.description,
    required super.isFeatured,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    LocalizedTextModel description;
    if (json['description'] is Map<String, dynamic>) {
      description = LocalizedTextModel.fromJson(json['description']);
    } else {
      description = LocalizedTextModel(ru: '', uz: '');
    }

    return CategoryModel(
      id: json['id'],
      slug: json['slug'],
      name: LocalizedTextModel.fromJson(json['name']),
      description: description,
      isFeatured: json['is_featured'] ?? false,
    );
  }
}
