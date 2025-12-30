import 'package:my_template/features/global_entity_model/localized_text/localized_text_entity.dart';

class ProductsCategoryEntity {
  final int id;
  final String slug;
  final LocalizedTextEntity name;

  ProductsCategoryEntity({
    required this.id,
    required this.slug,
    required this.name,
  });


}
