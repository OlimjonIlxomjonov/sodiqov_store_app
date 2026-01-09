import 'package:my_template/features/purchase_history/domain/entity/local_purchase_history/purchase_item_entity.dart';

class PurchaseHistoryEntity {
  final String id;
  final DateTime purchasedAt;
  final List<PurchaseItemEntity> items;
  final double totalPrice;
  final String phone;
  final String address;

  PurchaseHistoryEntity({
    required this.id,
    required this.purchasedAt,
    required this.items,
    required this.totalPrice,
    required this.phone,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'purchasedAt': purchasedAt.toIso8601String(),
    'totalPrice': totalPrice,
    'phone': phone,
    'address': address,
    'items': items.map((e) => e.toJson()).toList(),
  };

  factory PurchaseHistoryEntity.fromJson(Map<String, dynamic> json) {
    return PurchaseHistoryEntity(
      id: json['id'],
      purchasedAt: DateTime.parse(json['purchasedAt']),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      phone: json['phone'],
      address: json['address'],
      items: (json['items'] as List)
          .map((e) => PurchaseItemEntity.fromJson(e))
          .toList(),
    );
  }
}
