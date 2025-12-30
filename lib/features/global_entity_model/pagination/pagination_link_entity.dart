class PaginationLinkEntity {
  final String? url;
  final String label;
  final int? page;
  final bool active;

  PaginationLinkEntity({
    required this.url,
    required this.label,
    required this.page,
    required this.active,
  });

  factory PaginationLinkEntity.fromJson(Map<String, dynamic> json) {
    return PaginationLinkEntity(
      url: json['url'],
      label: json['label'],
      page: json['page'],
      active: json['active'],
    );
  }
}
