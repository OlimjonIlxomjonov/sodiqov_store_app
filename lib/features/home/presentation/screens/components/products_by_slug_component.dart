import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_template/core/extensions/context_extension.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/home/domain/entity/products/products_entity.dart';

import '../../../../../core/commons/constants/colors/app_colors.dart';
import '../../../../../core/commons/constants/textstyles/app_text_style.dart';
import '../../../../../core/routes/route_generator.dart';
import '../../../../../core/services/cart_storage/cart_storage.dart';
import '../../../../../core/services/liked_product_storage/liked_product_storage.dart';

class ProductsBySlugComponent extends StatefulWidget {
  final ProductsEntity product;

  const ProductsBySlugComponent({super.key, required this.product});

  @override
  State<ProductsBySlugComponent> createState() =>
      _ProductsBySlugComponentState();
}

class _ProductsBySlugComponentState extends State<ProductsBySlugComponent> {
  final PageController _pageController = PageController();
  final _priceFormatter = NumberFormat('#,##0', 'en_US');
  int productAmount = 1;
  int _currentIndex = 0;
  bool _isFav = false;

  @override
  void initState() {
    super.initState();
    _loadFav();
  }

  Future<void> _loadFav() async {
    _isFav = await FavoritesStorage.isFavorite(widget.product.id);
    setState(() {});
  }

  String formatPrice(num price) {
    return _priceFormatter.format(price);
  }

  int discountPercent(int? oldPrice, int newPrice) {
    if (oldPrice == null || oldPrice == 0) return 0;
    return (((oldPrice - newPrice) / oldPrice) * 100).round();
  }

  void increment() {
    setState(() {
      productAmount++;
    });
  }

  void decrement() {
    if (productAmount <= 0) return;
    setState(() {
      productAmount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              actionsPadding: EdgeInsets.only(right: appW(10)),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.green),
                onPressed: () {
                  AppRoute.close();
                },
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    await FavoritesStorage.toggleFavorite(widget.product);
                    setState(() => _isFav = !_isFav);
                  },
                  icon: Icon(
                    _isFav ? Icons.favorite : Icons.favorite_border,
                    color: _isFav ? Colors.red : Colors.grey,
                  ),
                ),
              ],
            ),

            /// {IMAGE}
            SliverToBoxAdapter(
              child: Hero(
                tag: 'product-image-${widget.product.id}',
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      /// IMAGES
                      PageView.builder(
                        controller: _pageController,
                        itemCount: widget.product.images.length,
                        onPageChanged: (index) {
                          setState(() => _currentIndex = index);
                        },
                        itemBuilder: (context, index) {
                          return Image.network(
                            'https://sodiqovstore.uz/storage/${widget.product.images[index]}',
                            fit: BoxFit.cover,
                          );
                        },
                      ),

                      /// DOTS
                      if (widget.product.images.length > 1)
                        Positioned(
                          bottom: 12,
                          child: Row(
                            children: List.generate(
                              widget.product.images.length,
                              (index) => AnimatedContainer(
                                duration: Duration(milliseconds: 200),
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                width: _currentIndex == index
                                    ? appW(20)
                                    : appW(6),
                                height: appH(6),
                                decoration: BoxDecoration(
                                  color: _currentIndex == index
                                      ? AppColors.green
                                      : AppColors.greyScale.grey600,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            /// {DIVIDER}
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: appH(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: AppColors.greyScale.grey200),
                    ),
                    if (widget.product.oldPrice != null &&
                        widget.product.oldPrice! > widget.product.price)
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: appW(5)),
                        child: Text(
                          '-${discountPercent(widget.product.oldPrice?.toInt(), widget.product.price.toInt())}%',
                          style: AppTextStyles.source.regular(
                            fontSize: 12,
                            color: AppColors.white,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.greyScale.grey200,
                          ),
                        ),
                      ),

                    Expanded(
                      child: Divider(color: AppColors.greyScale.grey200),
                    ),
                  ],
                ),
              ),
            ),

            /// {PRODUCT BODY}
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: appW(20),
                  vertical: appH(20),
                ),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: appW(10),
                        vertical: appH(5),
                      ),
                      margin: EdgeInsets.only(bottom: appH(5)),
                      decoration: BoxDecoration(color: AppColors.greenFade),
                      child: Text(
                        widget.product.category.name.byLocale(context.locale),
                        style: AppTextStyles.source.regular(
                          fontSize: 12,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                    Text(
                      widget.product.name.byLocale(context.locale),
                      style: AppTextStyles.source.medium(fontSize: 15),
                    ),
                    SizedBox(height: appH(20)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: appH(10),
                        horizontal: appW(15),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greyScale.grey200),
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            context.localizations.productCost.toUpperCase(),
                            style: AppTextStyles.source.regular(
                              fontSize: 12,
                              color: AppColors.greyScale.grey600,
                            ),
                          ),
                          if (widget.product.oldPrice != null &&
                              widget.product.oldPrice! > widget.product.price)
                            Text(
                              "${formatPrice(widget.product.oldPrice!)} UZS",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: AppResponsiveness.heigh(14),
                                color: AppColors.greyScale.grey600,
                              ),
                            ),
                          Text(
                            "${formatPrice(widget.product.price)} UZS",
                            style: AppTextStyles.source.medium(
                              fontSize: 22,
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: appH(15)),

                    /// mahsulot haqida
                    Row(
                      spacing: appW(5),
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: appW(2),
                            vertical: appH(10),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Text(
                          context.localizations.productInfo,
                          style: AppTextStyles.source.medium(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: appH(10)),
                    Text(
                      'Head & Shoulders shampooni - bu kepak va qichishishga qarshi eng yaxshi yechim. Maxsus formula soch va bosh terisini tozalaydi, namlaydi va himoya qiladi. 2 in 1 formula - shampun va konditsioner bir flakonida.',
                      style: AppTextStyles.source.regular(
                        fontSize: 12,
                        color: AppColors.greyScale.grey600,
                      ),
                    ),
                    SizedBox(height: appH(20)),
                    middleCard(
                      context.localizations.omborda,
                      '— ${context.localizations.storage}',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.greyScale.grey200)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: appW(15)),
            child: Column(
              spacing: appH(5),
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(
                      context.localizations.productAmount,
                      style: AppTextStyles.source.regular(
                        fontSize: 12,
                        color: AppColors.greyScale.grey600,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: appW(8),
                        vertical: appH(5),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.greyScale.grey300),
                      ),
                      child: Row(
                        spacing: appW(20),
                        children: [
                          addOrRemoveContainer(Icons.remove, decrement),
                          Text(productAmount.toString()),
                          addOrRemoveContainer(Icons.add, increment),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: appW(10),
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            context.localizations.totalCost,
                            style: AppTextStyles.source.regular(
                              fontSize: 12,
                              color: AppColors.greyScale.grey600,
                            ),
                          ),
                          Text(
                            "${formatPrice(widget.product.price * productAmount)} UZS",
                            style: AppTextStyles.source.medium(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, appH(45)),
                        ),
                        onPressed: () async {
                          await CartStorage.addProduct(
                            widget.product,
                            quantity: productAmount,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${widget.product.name.byLocale(context.locale)} savatga qo\'shildi',
                              ),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Row(
                          spacing: appW(5),
                          mainAxisAlignment: .center,
                          children: [
                            Icon(Icons.shopping_cart_outlined),
                            Text(context.localizations.toCart),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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

  Widget middleCard(String title, String desc) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: appW(10), vertical: appH(10)),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border.all(color: AppColors.greyScale.grey200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: appH(5),
        crossAxisAlignment: .start,
        children: [
          Text(
            title,
            style: AppTextStyles.source.regular(
              fontSize: 11,
              color: AppColors.greyScale.grey600,
            ),
          ),
          Text(desc, style: AppTextStyles.source.medium(fontSize: 14)),
        ],
      ),
    );
  }
}
