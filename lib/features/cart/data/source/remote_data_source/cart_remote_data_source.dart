abstract class CartRemoteDataSource {
  Future<void> sendOrder({
    required String phone,
    required String shippingAddress,
  });
}
