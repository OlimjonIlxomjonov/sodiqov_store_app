abstract class CartRepository {
  Future<void> postOrder({
    required String phone,
    required String shippingAddress,
  });
}
