class OrderItemRequest {
  final int productId;
  final int quantity;

  OrderItemRequest({required this.productId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {"product_id": productId, "quantity": quantity};
  }
}
