import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_template/features/home/domain/entity/products/products_entity.dart';

import '../../../features/home/data/model/products/products_model.dart';

class FavoritesStorage {
  static const _key = 'favorite_products';

  static Future<List<ProductsEntity>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    return list.map((e) => ProductsModel.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> toggleFavorite(ProductsEntity product) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    final index = list.indexWhere((e) {
      final json = jsonDecode(e);
      return json['id'] == product.id;
    });

    if (index >= 0) {
      list.removeAt(index);
    } else {
      list.add(jsonEncode(product.toJson()));
    }

    await prefs.setStringList(_key, list);
  }

  static Future<bool> isFavorite(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    return list.any((e) => jsonDecode(e)['id'] == id);
  }
}
