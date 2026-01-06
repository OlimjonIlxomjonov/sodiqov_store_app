import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_template/features/home/domain/entity/products/products_entity.dart';

import '../../../features/home/data/model/products/products_model.dart';

class CartStorage {
  static const String _key = 'cart_items';

  /// Decrease quantity for a product
  static Future<void> decreaseQuantity(
    ProductsEntity product, {
    int amount = 1,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getCartWithQuantity();
    final index = items.indexWhere(
      (e) => (e['product'] as ProductsEntity).id == product.id,
    );
    if (index != -1) {
      items[index]['quantity'] -= amount;
      if (items[index]['quantity'] <= 0) {
        items.removeAt(index);
      }
      final jsonList = items
          .map(
            (e) => jsonEncode({
              'product': (e['product'] as ProductsEntity).toJson(),
              'quantity': e['quantity'],
            }),
          )
          .toList();
      await prefs.setStringList(_key, jsonList);
    }
  }

  /// Add product to cart with quantity
  static Future<void> addProduct(
    ProductsEntity product, {
    int quantity = 1,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getCartWithQuantity();

    final index = items.indexWhere((e) => e['product'].id == product.id);

    if (index == -1) {
      items.add({'product': product, 'quantity': quantity});
    } else {
      items[index]['quantity'] += quantity;
    }

    final jsonList = items.map((e) {
      return jsonEncode({
        'product': e['product'].toJson(),
        'quantity': e['quantity'],
      });
    }).toList();

    await prefs.setStringList(_key, jsonList);
  }

  /// Remove product from cart
  static Future<void> removeProduct(dynamic id) async {
    final prefs = await SharedPreferences.getInstance();
    final items = await getCartWithQuantity();
    items.removeWhere(
      (e) =>
          e['product'].id == id || e['product'].id.toString() == id.toString(),
    );

    final jsonList = items.map((e) {
      return jsonEncode({
        'product': e['product'].toJson(),
        'quantity': e['quantity'],
      });
    }).toList();

    await prefs.setStringList(_key, jsonList);
  }

  /// Get cart with quantities
  static Future<List<Map<String, dynamic>>> getCartWithQuantity() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    final validItems = <Map<String, dynamic>>[];

    for (var e in list) {
      if (e == null || e.isEmpty) continue;

      try {
        final map = jsonDecode(e);
        if (map == null || map['product'] == null) continue;

        validItems.add({
          'product': ProductsModel.fromJson(map['product']),
          'quantity': (map['quantity'] ?? 1) as int,
        });
      } catch (_) {
        continue;
      }
    }

    return validItems;
  }

  /// Clear cart
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
