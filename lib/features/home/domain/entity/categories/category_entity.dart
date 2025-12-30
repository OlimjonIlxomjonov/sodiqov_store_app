import '../../../../global_entity_model/localized_text/localized_text_entity.dart';

class CategoryEntity {
  final int id;
  final String slug;
  final LocalizedTextEntity name;
  final LocalizedTextEntity description;
  final bool isFeatured;

  CategoryEntity({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
    required this.isFeatured,
  });
}
