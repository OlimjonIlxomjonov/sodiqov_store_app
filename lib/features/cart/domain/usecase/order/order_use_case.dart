import 'package:my_template/features/cart/domain/repository/cart_repository.dart';

class OrderUseCase {
  final CartRepository repository;

  OrderUseCase(this.repository);

  Future<void> call({
    required String phone,
    required String shippingAddress,
  }) {
    return repository.postOrder(
      phone: phone,
      shippingAddress: shippingAddress,
    );
  }
}
