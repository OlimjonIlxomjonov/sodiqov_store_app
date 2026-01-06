import 'package:my_template/features/cart/data/source/remote_data_source/cart_remote_data_source.dart';
import 'package:my_template/features/cart/domain/repository/cart_repository.dart';

class CartRepoImpl implements CartRepository {
  final CartRemoteDataSource remoteDataSource;

  CartRepoImpl(this.remoteDataSource);

  @override
  Future<void> postOrder({
    required String phone,
    required String shippingAddress,
  }) {
    return remoteDataSource.sendOrder(
      phone: phone,
      shippingAddress: shippingAddress,
    );
  }
}
