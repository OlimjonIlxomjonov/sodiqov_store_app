import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/core/commons/constants/textstyles/app_text_style.dart';
import 'package:my_template/core/extensions/context_extension.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/cart/presentation/screens/confirm_order_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/services/cart_storage/cart_storage.dart';
import '../../../home/domain/entity/products/products_entity.dart';

class CartPage extends StatefulWidget {
  final VoidCallback? onCartChanged;

  const CartPage({super.key, this.onCartChanged});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<ProductsEntity> cartItems = [];
  final _priceFormatter = NumberFormat('#,##0', 'en_US');
  int productAmount = 1;
  Map<String, int> productAmounts = {};

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    final itemsWithQty = await CartStorage.getCartWithQuantity();

    setState(() {
      cartItems = itemsWithQty
          .map((e) => e['product'] as ProductsEntity)
          .toList();
      productAmounts = {
        for (var e in itemsWithQty)
          (e['product'] as ProductsEntity).id.toString(): e['quantity'] as int,
      };
    });
  }

  String formatPrice(num price) {
    return _priceFormatter.format(price);
  }

  void increment(String id) async {
    setState(() {
      productAmounts[id] = (productAmounts[id] ?? 1) + 1;
    });

    final product = cartItems.firstWhere((p) => p.id.toString() == id);
    await CartStorage.addProduct(product, quantity: 1);
  }

  void decrement(String id) async {
    if ((productAmounts[id] ?? 1) <= 1) return;

    setState(() {
      productAmounts[id] = (productAmounts[id] ?? 1) - 1;
    });

    final product = cartItems.firstWhere((p) => p.id.toString() == id);
    final items = await CartStorage.getCartWithQuantity();
    final index = items.indexWhere(
      (e) => (e['product'] as ProductsEntity).id.toString() == id,
    );
    if (index != -1) {
      items[index]['quantity'] -= 1;
      if (items[index]['quantity'] <= 0) {
        items.removeAt(index);
      }
      // final prefs = await SharedPreferences.getInstance();
      // final jsonList = items
      //     .map(
      //       (e) => jsonEncode({
      //         'product': (e['product'] as ProductsEntity).toJson(),
      //         'quantity': e['quantity'],
      //       }),
      //     )
      //     .toList();
      await CartStorage.decreaseQuantity(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: cartItems.isEmpty
            ? Center(
                child: Column(
                  spacing: appH(10),
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "Savatcha bo'sh",
                      style: AppTextStyles.source.medium(fontSize: 18),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.green, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: AppColors.green,
                      ),
                      onPressed: () {
                        AppRoute.close();
                      },
                      child: Text(
                        'Toldirish',
                        style: AppTextStyles.source.medium(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: AppColors.white,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    floating: true,
                    pinned: false,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back, color: AppColors.green),
                      onPressed: () => AppRoute.close(),
                    ),
                    title: Text(
                      context.localizations.cart,
                      style: AppTextStyles.source.semiBold(fontSize: 16),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () async {
                          await CartStorage.clearCart();
                          await _loadCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Savatcha tozalandi'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          widget.onCartChanged?.call();
                        },
                        icon: Row(
                          spacing: appH(5),
                          children: [
                            Icon(IconlyLight.delete, color: AppColors.red),
                            Text(
                              context.localizations.clear,
                              style: AppTextStyles.source.regular(
                                fontSize: 13,
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: appH(5)),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = cartItems[index];
                        final quantity =
                            productAmounts[item.id.toString()] ?? 1;

                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.greyScale.grey200,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: appW(15),
                            vertical: appH(5),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: appW(15),
                            vertical: appH(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: appW(60),
                                height: appH(75),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(10),
                                  image: item.images.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            'https://sodiqovstore.uz/storage/${item.images.first}',
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                ),
                              ),
                              SizedBox(width: appW(10)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.name.byLocale(
                                                  context.locale,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyles.source
                                                    .medium(fontSize: 14),
                                              ),
                                              Text(
                                                item.category.name.byLocale(
                                                  context.locale,
                                                ),
                                                style: AppTextStyles.source
                                                    .regular(
                                                      fontSize: 12,
                                                      color: AppColors
                                                          .greyScale
                                                          .grey600,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            IconlyLight.delete,
                                            color: AppColors.red,
                                          ),
                                          onPressed: () async {
                                            await CartStorage.removeProduct(
                                              item.id,
                                            );
                                            await _loadCart();
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '${item.name.uz} savatchadan o\'chirildi',
                                                ),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                            widget.onCartChanged?.call();
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: appH(5)),
                                    Row(
                                      mainAxisAlignment: .spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${formatPrice(item.price * quantity)} UZS',
                                            style: AppTextStyles.source
                                                .semiBold(fontSize: 15),
                                          ),
                                        ),
                                        Row(
                                          spacing: appW(10),
                                          children: [
                                            addOrRemoveContainer(
                                              Icons.remove,
                                              () =>
                                                  decrement(item.id.toString()),
                                            ),
                                            Text(quantity.toString()),
                                            addOrRemoveContainer(
                                              Icons.add,
                                              () =>
                                                  increment(item.id.toString()),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }, childCount: cartItems.length),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: appH(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    minimumSize: Size(double.infinity, appH(45)),
                  ),
                  onPressed: () {
                    AppRoute.go(ConfirmOrderPage());
                  },
                  child: Text(
                    context.localizations.orderProduct,
                    style: AppTextStyles.source.medium(fontSize: 14),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget addOrRemoveContainer(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.greyScale.grey600),
      ),
    );
  }
}
