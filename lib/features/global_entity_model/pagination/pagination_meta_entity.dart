import 'package:my_template/features/global_entity_model/pagination/pagination_link_entity.dart';

class PaginationMetaEntity {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final List<PaginationLinkEntity> links;

  PaginationMetaEntity({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.links,
  });

  factory PaginationMetaEntity.fromJson(Map<String, dynamic> json) {
    return PaginationMetaEntity(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
      links: (json['links'] as List)
          .map((e) => PaginationLinkEntity.fromJson(e))
          .toList(),
    );
  }
}
