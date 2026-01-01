import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/features/home/domain/entity/products/products_entity.dart';
import 'package:my_template/features/home/presentation/bloc/home_event.dart';
import 'package:my_template/features/home/presentation/bloc/products_by_slug/products_by_slug_bloc.dart';
import 'package:my_template/features/home/presentation/screens/components/products_by_slug_component.dart';

import '../../../../../core/commons/constants/colors/app_colors.dart';
import '../../../../../core/commons/constants/textstyles/app_text_style.dart';
import '../../../../../core/utils/responsiveness/app_responsiveness.dart';

class ProductCard extends StatefulWidget {
  final ProductsEntity item;
  final bool enableHero;

  const ProductCard({super.key, required this.item, this.enableHero = false});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final _priceFormatter = NumberFormat('#,##0', 'en_US');

  String formatPrice(num price) {
    return _priceFormatter.format(price);
  }

  int discountPercent(int? oldPrice, int newPrice) {
    if (oldPrice == null || oldPrice == 0) return 0;
    return (((oldPrice - newPrice) / oldPrice) * 100).round();
  }

  String buildImageUrl(String path) {
    if (path.startsWith('http')) return path;
    return 'https://sodiqovstore.uz/storage/$path';
  }

  @override
  Widget build(BuildContext context) {
    final heroTag = 'product-image-${widget.item.id}';
    return GestureDetector(
      onTap: () {
        context.read<ProductsBySlugBloc>().add(
          ProductsBySlugEvent(widget.item.slug),
        );
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 250),
            reverseTransitionDuration: const Duration(milliseconds: 250),
            pageBuilder: (_, __, ___) =>
                ProductsBySlugComponent(product: widget.item),
            transitionsBuilder: (_, animation, __, child) {
              final slide =
                  Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  );

              return SlideTransition(position: slide, child: child);
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.greyScale.grey200,
              offset: Offset(0, 4),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(flex: 2, child: buildHero(heroTag)),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: appW(10),
                  top: appH(5),
                  bottom: appH(2),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.greyScale.grey300),
                  ),
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name.uz,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.source.medium(fontSize: 14),
                    ),
                    Text(
                      widget.item.category.name.uz,
                      style: AppTextStyles.source.regular(fontSize: 12),
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.item.oldPrice != null &&
                                widget.item.oldPrice! > widget.item.price)
                              Text(
                                "${formatPrice(widget.item.oldPrice!)} so'm",
                                style: TextStyle(
                                  fontSize: AppResponsiveness.heigh(12),
                                  color: AppColors.greyScale.grey600,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            Text(
                              "${formatPrice(widget.item.price)} so'm",
                              style: AppTextStyles.source.medium(fontSize: 14),
                            ),
                          ],
                        ),
                        IconButton(
                          style: IconButton.styleFrom(
                            backgroundColor: AppColors.greenFade,
                          ),
                          onPressed: () {},
                          icon: Icon(Icons.add, color: AppColors.green),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHero(String heroTag) {
    Widget content = Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          image: widget.item.images.isNotEmpty
              ? DecorationImage(
                  image: NetworkImage(buildImageUrl(widget.item.images.first)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// DISCOUNT BADGE
                if (widget.item.oldPrice != null &&
                    widget.item.oldPrice! > widget.item.price)
                  Container(
                    decoration: BoxDecoration(color: AppColors.red),
                    margin: EdgeInsets.only(left: appW(10)),
                    padding: EdgeInsets.symmetric(horizontal: appW(5)),
                    child: Text(
                      '-${discountPercent(widget.item.oldPrice?.toInt(), widget.item.price.toInt())}%',
                      style: AppTextStyles.source.regular(
                        fontSize: 12,
                        color: AppColors.white,
                      ),
                    ),
                  ),

                Expanded(child: Container()),

                /// HEART BUTTON
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                  ),
                  onPressed: () {},
                  icon: Icon(IconlyBold.heart, color: AppColors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // ✅ HERO ONLY WHEN ENABLED
    if (widget.enableHero) {
      return Hero(tag: heroTag, child: content);
    }

    return content;
  }
}
