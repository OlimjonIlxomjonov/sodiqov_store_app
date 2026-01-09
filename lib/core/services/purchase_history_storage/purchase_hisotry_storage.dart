import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/purchase_history/domain/entity/local_purchase_history/purchase_history_entity.dart';

class PurchaseHistoryStorage {
  static const _key = 'purchase_history';

  /// SAVE ORDER
  static Future<void> addPurchase(PurchaseHistoryEntity order) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    list.add(jsonEncode(order.toJson()));
    await prefs.setStringList(_key, list);
  }

  /// GET ALL ORDERS
  static Future<List<PurchaseHistoryEntity>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    return list
        .map((e) => PurchaseHistoryEntity.fromJson(jsonDecode(e)))
        .toList()
        .reversed
        .toList();
  }

  /// CLEAR HISTORY
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
