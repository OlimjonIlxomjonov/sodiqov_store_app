import 'package:dio/dio.dart';
import 'package:my_template/core/commons/constants/api_urls/api_urls.dart';
import 'package:my_template/core/network/dio_client.dart';
import 'package:my_template/core/utils/logger/logger.dart';
import 'package:my_template/features/cart/data/source/remote_data_source/cart_remote_data_source.dart';

import '../../../../../core/services/cart_storage/cart_storage.dart';
import '../../../../home/domain/entity/products/products_entity.dart';
import '../../../domain/entity/order/order_item_request.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final dioClient = DioClient();

  @override
  Future<void> sendOrder({
    required String phone,
    required String shippingAddress,
  }) async {
    try {
      final cartItemsWithQty = await CartStorage.getCartWithQuantity();

      final items = cartItemsWithQty.map((e) {
        final product = e['product'] as ProductsEntity;
        final quantity = e['quantity'] as int;

        return OrderItemRequest(productId: product.id, quantity: quantity);
      }).toList();

      final response = await dioClient.post(
        ApiUrls.order,
        data: {
          "phone": phone,
          "shipping_address": shippingAddress,
          "items": items.map((e) => e.toJson()).toList(),
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i("SUCCESS: ${response.statusCode}");
      } else {
        throw Exception('ERROR OCCURRED! ${response.statusCode}');
      }
    } catch (e) {
      logger.e('ERROR $e');
      rethrow;
    }
  }
}
