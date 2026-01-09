import '../../../../home/data/model/products/products_model.dart';
import '../../../../home/domain/entity/products/products_entity.dart';

class PurchaseItemEntity {
  final ProductsEntity product;
  final int quantity;

  PurchaseItemEntity({required this.product, required this.quantity});

  Map<String, dynamic> toJson() => {
    'product': product.toJson(),
    'quantity': quantity,
  };

  factory PurchaseItemEntity.fromJson(Map<String, dynamic> json) {
    return PurchaseItemEntity(
      product: ProductsModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
}
